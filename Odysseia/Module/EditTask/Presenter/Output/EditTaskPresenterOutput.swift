//
//  EditTaskPresenterOutput.swift
//  Odysseia
//
//  Created by lcr on 2020/11/04.
//

protocol EditTaskPresenterOutput: AnyObject {
    // GoalDetailPresenter -> EditTaskPresenter
    func successUpdete(task: Task)
}
