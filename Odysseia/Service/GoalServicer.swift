//
//  GoalServicer.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//

import CoreData

protocol GoalServiceProtocol {
    // Goal
    func add(goal: TemporaryGoal) throws -> Goal
    func add(goal: TemporaryGoal, tasks: [TemporaryTask]) throws -> Goal
    func update(goal: Goal) throws -> Goal
    func delete(goal: Goal) throws
    func get(objectId: NSManagedObjectID) throws -> Goal
    func getAll() throws -> [Goal]

    // Task
    func update(task: Task) throws -> Task
}

class GoalServicer {
    static let shared = GoalServicer()
    let persistentContainer = PersistentContainerProvider.getInstance()
    lazy var managedContext: NSManagedObjectContext = { persistentContainer.viewContext
    }()
    // 外部からのインスタンス生成を禁止
    private init() {}
}

extension GoalServicer: GoalServiceProtocol {
    func add(goal: TemporaryGoal, tasks: [TemporaryTask]) throws -> Goal {
        let newGoal = Goal(context: managedContext)
        newGoal.title = goal.title
        newGoal.detail = goal.detail
        newGoal.deadlineDate = goal.deadlineDate

        for task in tasks {
            let newTask = Task(context: managedContext)
            newTask.title = task.title
            newTask.targetCount = Int16(task.targetCount)
            newTask.goal = newGoal
        }

        do {
            try managedContext.save()
        } catch {
            throw GoalServiceError.addGoalError(msg: L10n.Localizable.addGoalErrorMsg)
        }
        return newGoal
    }

    func add(goal: TemporaryGoal) throws -> Goal {
        let newGoal = Goal(context: managedContext)
        newGoal.title = goal.title
        newGoal.detail = goal.detail
        newGoal.deadlineDate = goal.deadlineDate
        do {
            try managedContext.save()
        } catch {
            throw GoalServiceError.addGoalError(msg: L10n.Localizable.addGoalErrorMsg)
        }
        return newGoal
    }

    func delete(goal: Goal) throws {
        managedContext.delete(goal)
        do {
            try managedContext.save()
        } catch {
            throw GoalServiceError.deleteGoalError(msg: L10n.Localizable.deleteGoalErrorMsg)
        }
    }

    func update(goal: Goal) throws -> Goal {
        do {
            try managedContext.save()
        } catch {
            throw GoalServiceError.updateGoalError(msg: L10n.Localizable.updateGoalErrorMsg)
        }
        return goal
    }

    func get(objectId: NSManagedObjectID) throws -> Goal {
        do {
            let result = try managedContext.existingObject(with: objectId)
            if let goal = result as? Goal {
                return goal
            }
            throw GoalServiceError.getGoalError(msg: L10n.Localizable.getGoalErrorMsg)
        } catch {
            throw error
        }
    }

    func getAll() throws -> [Goal] {
        do {
            let result = try managedContext.fetch(Goal.fetchRequest())
            if let goals = result as? [Goal] {
                return goals
            }
            throw GoalServiceError.getGoalError(msg: L10n.Localizable.getGoalErrorMsg)
        } catch {
            throw error
        }
    }

    func update(task: Task) throws -> Task {
        if task.isDone() && task.reachDate == nil {
            task.reachDate = Date()
        } else if task.isDone() && task.reachDate != nil {
            task.reachDate = nil
        }
        guard let goal = task.goal else {
            return task
        }
        if goal.isAllTasksDone() && goal.reatchDate == nil {
            goal.reatchDate = Date()
        } else if goal.isAllTasksDone() && goal.reatchDate != nil {
            goal.reatchDate = nil
        }
        do {
            try managedContext.save()
        } catch {
            throw GoalServiceError.updateTaskError(msg: L10n.Localizable.updateGoalErrorMsg)
        }
        return task
    }
}

enum GoalServiceError: Error {
    case getGoalError(msg: String)
    case updateGoalError(msg: String)
    case addGoalError(msg: String)
    case deleteGoalError(msg: String)
    case updateTaskError(msg: String)
}
