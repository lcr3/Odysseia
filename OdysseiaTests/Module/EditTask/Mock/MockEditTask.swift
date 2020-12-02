//
//  MockEditTask.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/12/02.
//

@testable import Odysseia
import UIKit

class MockEditTaskView: EditTaskView {
    var presenter: EditTaskPresentation!
    var callCountShowErrorAlert = 0
    var callCountReachCount = 0
    var showErrorAlertMsg = ""
    var setReachCountText = ""

    func showErrorAlert(msg: String) {
        callCountShowErrorAlert += 1
        showErrorAlertMsg = msg
    }

    func setReachCount(text: String) {
        callCountReachCount += 1
        setReachCountText = text
    }
}

class StubTask: Task {
    convenience init(title: String = "", reachCount: Int16 = 0, targetCount: Int16 = 0) {
        self.init()

        self.stubbedTitle = title
        self.stubbedReachCount = reachCount
        self.targetCount = targetCount
    }

    var stubbedTitle: String = ""
    var stubbedReachCount: Int16 = 0
    var stubbedTargetCount: Int16 = 0
    override var title: String {
        get {
            stubbedTitle
        }
        set { stubbedTitle = newValue }
    }
    override var reachCount: Int16 {
        get {
            stubbedReachCount
        }
        set { stubbedReachCount = newValue }
    }
    override var targetCount: Int16 {
        get {
            stubbedTargetCount
        }
        set { stubbedTargetCount = newValue }
    }
}
class MockEditTaskPresenter: EditTaskPresentation {
    var task: Task = StubTask(title: "")
    var callCountViewDidLoad = 0
    var callCountIncrementButtonTouched = 0
    var callCountDecrementButtonTouched = 0
    var callCountUpdateButtonTouched = 0
    var callCountUpdateTitle = 0
    var updateTitle = ""

    func viewDidLoad() {
        callCountViewDidLoad += 1
    }

    func incrementButtonTouched() {
        callCountIncrementButtonTouched += 1
    }

    func decrementButtonTouched() {
        callCountDecrementButtonTouched += 1
    }

    func updateButtonTouched() {
        callCountUpdateButtonTouched += 1
    }

    func updateTitle(title: String) {
        callCountUpdateTitle += 1
        updateTitle = title
    }
}

class MockEditTaskInteractorOutput: EditTaskInteractorOutput {
    var callCountSccessUpdate = 0
    var callCountFaildUpdate = 0
    var sccessUpdateTask: Task?
    var faildUpdateMsg = ""

    func sccessUpdate(task: Task) {
        callCountSccessUpdate += 1
        sccessUpdateTask = task
    }

    func faildUpdate(msg: String) {
        callCountFaildUpdate += 1
        faildUpdateMsg = msg
    }
}

class MockEditTaskPresenterOutput: EditTaskPresenterOutput {
    var callCountSuccessUpdata = 0
    func successUpdete(task: Task) {
        callCountSuccessUpdata += 1
    }
}

class MockEditTaskInteractor: EditTaskUsecase {
    var service: GoalServiceProtocol = MockGoalService()
    var output: EditTaskInteractorOutput?
    var callCountUpdate = 0
    func update(task: Task) {
        callCountUpdate += 1
    }
}

class MockEditTaskRouter: EditTaskWireframe {
    var callCountDismiss = 0
    func dismiss() {
        callCountDismiss += 1
    }
}
