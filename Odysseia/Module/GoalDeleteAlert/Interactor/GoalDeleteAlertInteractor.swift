//
//  GoalDeleteAlertViewController.swift
//  Odysseia
//
//  Created by lcr on 2020/11/11.
//

import CoreData

protocol GoalDeleteAlertUsecase: AnyObject {
    var output: GoalDeleteAlertInteractorOutput? { get }
    func deleteGoal(goal: Goal)
}

class GoalDeleteAlertInteractor {
    weak var output: GoalDeleteAlertInteractorOutput?
    let service: GoalServicer

    init(service: GoalServicer) {
        self.service = service
    }
}

extension GoalDeleteAlertInteractor: GoalDeleteAlertUsecase {
    func deleteGoal(goal: Goal) {
        do {
            try service.delete(goal: goal)
            output?.successDelete()
        } catch {
            //            output?.failedLoad(error: error)
        }
    }
}
