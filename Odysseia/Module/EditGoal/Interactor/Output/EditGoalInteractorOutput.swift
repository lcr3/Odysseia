//
//  EditGoalInteractorOutput.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//

protocol EditGoalInteractorOutput: AnyObject {
    // Interactor -> Presenter
    func successEditGoal(goal: Goal)
    func failedEditGoal(msg: String)
}
