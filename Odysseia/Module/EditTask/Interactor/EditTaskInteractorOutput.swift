//
//  EditTaskInteractorOutput.swift
//  Odysseia
//
//  Created by lcr on 02/11/2020.
//

import Foundation

protocol EditTaskInteractorOutput: AnyObject {
    // Interactor -> Output
    func sccessUpdate(task: Task)
    func faildUpdate(msg: String)
}
