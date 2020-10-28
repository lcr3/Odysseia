//
//  GoalDetailInteractorOutput.swift
//  Odysseia
//
//  Created by lcr on 2020/10/21.
//

protocol GoalDetailInteractorOutput: AnyObject {
    // Interactor -> Output
    func failedLoad(error: Error)
    func successLoad(goal: Goal)
}
