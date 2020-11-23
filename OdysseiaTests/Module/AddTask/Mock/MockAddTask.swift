//
//  MockAddTask.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/11/23.
//

@testable import Odysseia
import UIKit

class MockAddTaskView: AddTaskView {
    var presenter: AddTaskPresentation!
    var addTaskButton: UIButton! = UIButton()

    var callCountReload = 0
    var callCountValidationError = 0
    var callCountShowDeleteAlert = 0

    func reload(tasks: [TemporaryTask]) {
        callCountReload += 1
    }

    func validationError(msg: String) {
        callCountValidationError += 1
    }

    func showDeleteAlert(row: Int) {
        callCountShowDeleteAlert += 1
    }
}

class MockAddTaskPresenter: AddTaskPresentation {
    var tasks: [TemporaryTask] = []
    var callCountViewDidLayoutSubviews = 0
    var callCountTaskCellTouched = 0
    var callCountAddTaskButtonTouched = 0
    var callCountDoneButtonTouched = 0
    var callCountBackButtonTouched = 0
    var callCountDeleteButtonTouched = 0

    func viewDidLayoutSubviews() {
        callCountViewDidLayoutSubviews += 1
    }

    func taskCellTouched(row: Int) {
        callCountTaskCellTouched += 1
    }

    func addTaskButtonTouched() {
        callCountAddTaskButtonTouched += 1
    }

    func doneButtonTouched() {
        callCountDoneButtonTouched += 1
    }

    func backButtonTouched() {
        callCountBackButtonTouched += 1
    }

    func deleteButtonTouched(row: Int) {
        callCountDeleteButtonTouched += 1
    }
}

class MockAddTaskInteractor: AddTaskUsecase {
    var service: GoalServiceProtocol = MockGoalService()
    var output: AddTaskInteractorOutput?

    var callCountAddGoal = 0
    func addGoal(goal: TemporaryGoal, tasks: [TemporaryTask]) {
        callCountAddGoal += 1
    }
}

class MockAddTaskRouter: AddTaskWireframe {
    var callCountShowTutorial = 0
    var callCountDismiss = 0
    var callCountBack = 0
    var callCountShowAddTaskInput = 0

    func showTutorial(tutorialButtonFrame: CGRect) {
        callCountShowTutorial += 1
    }

    func dismiss() {
        callCountDismiss += 1
    }

    func back() {
        callCountBack += 1
    }

    func showAddTaskInput(outut: TaskInputPresenterOutput) {
        callCountShowTutorial += 1
    }
}
