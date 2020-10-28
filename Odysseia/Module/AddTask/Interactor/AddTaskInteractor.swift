//
//  AddTaskInteractor.swift
//  Odysseia
//
//  Created by lcr on 27/10/2020.
//

import Foundation

import CoreData

protocol AddTaskUsecase: AnyObject {
    var output: AddTaskInteractorOutput? { get }
    var service: GoalServicer { get }
    func addGoal(title: String, tasks: [TemporaryTask])
}

class AddTaskInteractor {
    weak var output: AddTaskInteractorOutput?
    let service: GoalServicer

    init(service: GoalServicer) {
        self.service = service
    }
}

extension AddTaskInteractor: AddTaskUsecase {
    func addGoal(title: String, tasks: [TemporaryTask]) {
        //        do {
        //            let newGoal = try service.add(goal: goal)
        ////            output?.successAddTask(goal: newGoal)
        //        } catch {
        ////            output?.failedAddTask(msg: error.localizedDescription)
        //        }
    }
}
