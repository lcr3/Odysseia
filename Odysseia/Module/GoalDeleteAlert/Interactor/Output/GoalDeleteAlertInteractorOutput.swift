//
//  GoalDeleteAlertInteractorOutput.swift
//  Odysseia
//
//  Created by lcr on 2020/11/11.
//

protocol GoalDeleteAlertInteractorOutput: AnyObject {
    // Interactor -> Output
    func failedDelete(error: Error)
    func successDelete()
}
