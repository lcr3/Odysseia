//
//  AddTaskInteractor.swift
//  Odysseia
//
//  Created by lcr on 27/10/2020.
//

import CoreData

protocol AddTaskUsecase: AnyObject {
    var output: AddTaskInteractorOutput? { get }
    var service: GoalServicer { get }
    func addGoal(goal: TemporaryGoal, tasks: [TemporaryTask])
}

class AddTaskInteractor {
    weak var output: AddTaskInteractorOutput?
    let service: GoalServicer

    init(service: GoalServicer) {
        self.service = service
    }
}

extension AddTaskInteractor: AddTaskUsecase {
    func addGoal(goal: TemporaryGoal, tasks: [TemporaryTask]) {
        do {
            let newGoal = try service.add(goal: goal, tasks: tasks)
            output?.successAddGoal(goal: newGoal)
        } catch {
            output?.failedAddGoal(msg: error.localizedDescription)
        }
    }
}
