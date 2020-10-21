//
//  EditGoalInteractor.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//

import CoreData

protocol EditGoalUsecase: AnyObject {
    var output: EditGoalInteractorOutput? { get }
    func edit(goal: Goal)
}

class EditGoalInteractor {
    weak var output: EditGoalInteractorOutput?
    private let service = GoalServicer.shared
}

extension EditGoalInteractor: EditGoalUsecase {
    func edit(goal: Goal) {
        do {
            let updatedGoal = try service.update(goal: goal)
            output?.successEditGoal(goal: updatedGoal)
        } catch {
            output?.failedEditGoal(msg: error.localizedDescription)
        }
    }
}
