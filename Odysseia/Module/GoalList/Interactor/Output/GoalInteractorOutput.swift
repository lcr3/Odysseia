//
//  GoalInteractorOutput.swift
//  CoreDataSample
//
//  Created by lcr on 2020/10/19.
//
import Foundation

protocol GoalListInteractorOutput: AnyObject {
    // Interactor -> Output
    func failedLoad(error: Error)
    func successLoad(goals: [Goal])
}
