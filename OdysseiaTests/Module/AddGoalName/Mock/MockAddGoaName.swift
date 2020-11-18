//
//  MockAddGoaName.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/11/14.
//

@testable import Odysseia

class MockAddGoalNamePresenter: AddGoalNamePresentation {
    var callCountNextButtonTouched = 0
    var callCountUpdateGoal = 0
    var callCountUpdateDedline = 0
    var callCountValidationError = 0

    func nextButtonTouched(title: String) {
        callCountNextButtonTouched += 1
    }

    func updateGoal(name: String) {
        callCountUpdateGoal += 1
    }

    func updateDedline(year: Int) {
        callCountUpdateDedline += 1
    }

    func validationError(msg: String) {
        callCountValidationError += 1
    }
}

class MockAddGoalNameView: AddGoalNameView {
    var presenter: AddGoalNamePresentation!
    var callCountViewDidLoad = 0
    var callCountChangeButton = 0
    var callCountValidationError = 0
    var changeButtonEnable = false
    var validationErrorMsg = ""

    func viewDidLoad() {
        callCountViewDidLoad += 1
    }

    func changeButton(enable: Bool) {
        callCountChangeButton += 1
        changeButtonEnable = enable
    }

    func validationError(msg: String) {
        callCountValidationError += 1
        validationErrorMsg = msg
    }
}

class MockAddGoalNameRouter: AddGoalNameWireframe {
    var callCountShowAddTask = 0
    func showAddTask(goal: TemporaryGoal) {
        callCountShowAddTask += 1
    }
}
