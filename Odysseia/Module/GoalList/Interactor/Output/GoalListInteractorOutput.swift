//
//  GoalListInteractorOutput.swift
//  Odysseia
//
//  Created by lcr on 2020/10/19.
//

protocol GoalListInteractorOutput: AnyObject {
    // Interactor -> Output
    func failedLoad(error: Error)
    func successLoad(goals: [Goal])
}
