//
//  AddGoalInteractorOutput.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//

protocol AddGoalInteractorOutput: AnyObject {
    // Interactor -> Presenter
    func successAddGoal(goal: Goal)
    func failedAddGoal(msg: String)
}
