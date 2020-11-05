//
//  AddTaskInteractorOutput.swift
//  Odysseia
//
//  Created by lcr on 2020/10/28.
//

protocol AddTaskInteractorOutput: AnyObject {
    // Interactor -> Presenter
    func successAddGoal(goal: Goal)
    func failedAddGoal(msg: String)
}
