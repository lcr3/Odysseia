//
//  AddGoalInteractor.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//

import CoreData

protocol AddGoalUsecase: AnyObject {
    var output: AddGoalInteractorOutput? { get }
    var service: GoalServicer { get }
    func addGoal(goal: TemporaryGoal)
}

class AddGoalInteractor {
    weak var output: AddGoalInteractorOutput?
    let service: GoalServicer

    init(service: GoalServicer) {
        self.service = service
    }
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
