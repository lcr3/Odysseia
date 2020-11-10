//
//  TaskInputPresenterOutput.swift
//  Odysseia
//
//  Created by lcr on 2020/11/10.
//

protocol TaskInputPresenterOutput: AnyObject {
    // TaskInputPresenter -> AddTaskPresenter
    func successAddTask(title: String, targetLevel: Int)
}
