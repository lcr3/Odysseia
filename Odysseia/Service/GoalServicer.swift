//
//  File.swift
//  Odysseial
//
//  Created by lcr on 2020/10/20.
//

import CoreData

protocol GoalService {
    func add(goal: TemporaryGoal) throws -> Goal
    func update(goal: Goal) throws -> Goal
    func delete(id: String) throws
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
        do {
            try managedContext.save()
        } catch {
            throw GoalServiceError.addError(msg: "データの追加に失敗しました")
        }
        return newGoal
    }

    func delete(id: String) throws {
        throw GoalServiceError.deleteError(msg: "データの削除に失敗しました")
    }

    func update(goal: Goal) throws -> Goal {
        do {
            try managedContext.save()
        } catch {
            throw GoalServiceError.updateError(msg: "データの更新に失敗しました")
        }
        return goal
    }

    func getAll() throws -> [Goal] {
        do {
            let result = try managedContext.fetch(Goal.fetchRequest())
            if let goals = result as? [Goal] {
                return goals
            }
            throw GoalServiceError.getError(msg: "データの取得に失敗しました")
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
