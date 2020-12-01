//
//  GoalServicer.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//

import CoreData

protocol GoalServiceProtocol {
    // Goal
    func add(goal: TemporaryGoal, tasks: [TemporaryTask]) throws -> Goal
    func update(goal: Goal) throws -> Goal
    func delete(goal: Goal) throws
    func get(uuid: String) throws -> Goal
    func getAll() throws -> [Goal]

    // Task
    func update(task: Task) throws -> Task
}

class GoalServicer {
    static let shared = GoalServicer()
    lazy var managedContext: NSManagedObjectContext = {
        PersistentContainerProvider.getInstance().viewContext
    }()
    private init() {}
}

extension GoalServicer: GoalServiceProtocol {
    func add(goal: TemporaryGoal, tasks: [TemporaryTask]) throws -> Goal {
        let newGoal = Goal(context: managedContext)
        newGoal.title = goal.title
        newGoal.detail = goal.detail
        newGoal.deadlineDate = goal.deadlineDate
        newGoal.createdAt = Date()

        for task in tasks {
            let newTask = Task(context: managedContext)
            newTask.title = task.title
            newTask.targetCount = Int16(task.targetCount)
            newTask.createdAt = Date()
            newTask.goal = newGoal
        }

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

    func delete(task: Task) throws {
        managedContext.delete(task)
        do {
            try managedContext.save()
        } catch {
            throw GoalServiceError.deleteGoalError(msg: L10n.Localizable.deleteTaskErrorMsg)
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

    func get(uuid: String) throws -> Goal {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        let predicate = NSPredicate(format: "%K = %@", "id", uuid)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = predicate
        do {
            let result = try managedContext.fetch(fetchRequest)
            if let goal = result.first as? Goal {
                return goal
            }
            throw GoalServiceError.getGoalError(msg: L10n.Localizable.getGoalErrorMsg)
        } catch {
            throw error
        }
    }

    func getAll() throws -> [Goal] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        //ascendind true 昇順、false 降順
        let sortDescripter = NSSortDescriptor(key: Goal.Key.createdAt.rawValue, ascending: true)
        fetchRequest.sortDescriptors = [sortDescripter]
        do {
            let result = try managedContext.fetch(fetchRequest)
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

    func allDelete() throws {
        let goals: [Goal]
        do {
            try goals = getAll()
        } catch {
            throw GoalServiceError.allDeleteError(msg: L10n.Localizable.allDeleteErrorMsg)
        }

        for goal in goals {
            for task in goal.getTasks() {
                do {
                    try delete(task: task)
                } catch {
                    throw GoalServiceError.allDeleteError(msg: L10n.Localizable.allDeleteErrorMsg)
                }
            }
            do {
                try delete(goal: goal)
            } catch {
                throw GoalServiceError.allDeleteError(msg: L10n.Localizable.allDeleteErrorMsg)
            }
        }
    }
}

enum GoalServiceError: Error {
    case getGoalError(msg: String)
    case updateGoalError(msg: String)
    case addGoalError(msg: String)
    case deleteGoalError(msg: String)
    case updateTaskError(msg: String)
    case allDeleteError(msg: String)
}
