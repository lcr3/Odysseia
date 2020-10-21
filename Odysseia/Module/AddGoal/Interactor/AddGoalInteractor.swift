//
//  AddGoalInteractor.swift
//  Odysseial
//
//  Created by lcr on 2020/10/20.
//

import CoreData

protocol AddGoalUsecase: AnyObject {
    var output: AddGoalInteractorOutput? { get }
    func addGoal(goal: TemporaryGoal)
}

class AddGoalInteractor {
    weak var output: AddGoalInteractorOutput?
    private let service = GoalServicer.shared
}

extension AddGoalInteractor: AddGoalUsecase {
    func addGoal(goal: TemporaryGoal) {
        do {
            let newGoal = try service.add(goal: goal)
            output?.successAddGoal(goal: newGoal)
        } catch {
            output?.failedAddGoal(msg: error.localizedDescription)
        }
    }
}
