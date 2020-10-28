//
//  GoalServicer.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//

import CoreData

protocol GoalService {
    func add(goal: TemporaryGoal) throws -> Goal
    func update(goal: Goal) throws -> Goal
    func delete(id: String) throws
    func get(objectId: NSManagedObjectID) throws -> Goal
    func getAll() throws -> [Goal]
}

class GoalServicer {
    static let shared = GoalServicer()
    let persistentContainer = PersistentContainerProvider.getInstance()
    lazy var managedContext: NSManagedObjectContext = { persistentContainer.viewContext
    }()
    // 外部からのインスタンス生成を禁止
    private init() {}
}

extension GoalServicer: GoalService {
    func add(goal: TemporaryGoal) throws -> Goal {
        let newGoal = Goal(context: managedContext)
        newGoal.title = goal.title
        newGoal.detail = goal.detail
        newGoal.planet = Int16(goal.planet.rawValue)
        do {
            try managedContext.save()
        } catch {
            throw GoalServiceError.addError(msg: L10n.Localizable.addGoalErrorMessage)
        }
        return newGoal
    }

    func delete(id: String) throws {
        throw GoalServiceError.deleteError(msg: L10n.Localizable.deleteGoalErrorMessage)
    }

    func update(goal: Goal) throws -> Goal {
        do {
            try managedContext.save()
        } catch {
            throw GoalServiceError.updateError(msg: L10n.Localizable.updateGoalErrorMessage)
        }
        return goal
    }

    func get(objectId: NSManagedObjectID) throws -> Goal {
        do {
            let result = try managedContext.existingObject(with: objectId)
            if let goal = result as? Goal {
                return goal
            }
            throw GoalServiceError.getError(msg: L10n.Localizable.getGoalErrorMessage)
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
            throw GoalServiceError.getError(msg: L10n.Localizable.getGoalErrorMessage)
        } catch {
            throw error
        }
    }
}

enum GoalServiceError: Error {
    case getError(msg: String)
    case updateError(msg: String)
    case addError(msg: String)
    case deleteError(msg: String)
}
