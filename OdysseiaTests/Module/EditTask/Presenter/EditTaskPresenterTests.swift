//
//  EditTaskPresenterTests.swift
//  Odysseia
//
//  Created by lcr on 02/11/2020.
//

@testable import Odysseia
import XCTest

class EditTaskPresenterTest: XCTestCase {
    var view: MockEditTaskView!
    var router: MockEditTaskRouter!
    var presenter: EditTaskPresenter!
    var interactor: MockEditTaskInteractor!
    var output: MockEditTaskPresenterOutput!
    var task: StubTask!

    override func setUp() {
        super.setUp()
        view = MockEditTaskView()
        router = MockEditTaskRouter()
        interactor = MockEditTaskInteractor()
        output = MockEditTaskPresenterOutput()
        task = StubTask(title: "fff", reachCount: 2, targetCount: 4)
        presenter = EditTaskPresenter(view: view, router: router, interactor: interactor, task: task, output: output)
    }

    func testViewDidLoad() {
        // execute
        presenter.viewDidLoad()

        // verify
        XCTAssertEqual(view.callCountReachCount, 1)
        XCTAssertEqual(view.setReachCountText, "2 / 4")
    }

    func testIncrementButtonTouched() {
        // setup
        let reachCount = 4
        let targetCount = 6
        presenter.editReachCount = reachCount
        presenter.editTargetCount = targetCount

        // execute
        presenter.incrementButtonTouched()

        // verify
        XCTAssertEqual(view.callCountReachCount, 1)
        XCTAssertEqual(view.setReachCountText, "\(reachCount + 1) / \(targetCount)")
    }

    func testMaxIncrement() {
        // setup
        presenter.editReachCount = 1
        presenter.editTargetCount = 1

        // execute
        presenter.incrementButtonTouched()

        // verify
        XCTAssertEqual(view.callCountReachCount, 0)
    }

    func testDecrementButtonTouched() {
        // setup
        let reachCount = 4
        let targetCount = 6
        presenter.editReachCount = reachCount
        presenter.editTargetCount = targetCount

        // execute
        presenter.decrementButtonTouched()

        // verify
        XCTAssertEqual(view.callCountReachCount, 1)
        XCTAssertEqual(view.setReachCountText, "\(reachCount - 1) / \(targetCount)")
    }

    func testMinIncrement() {
        // setup
        presenter.editReachCount = 0
        presenter.editTargetCount = 1

        // execute
        presenter.decrementButtonTouched()

        // verify
        XCTAssertEqual(view.callCountReachCount, 0)
    }

    func testUpdateTitle() {
        // setup
        let updateTitle = "update"

        // execute
        presenter.updateTitle(title: updateTitle)

        // verify
        XCTAssertEqual(presenter.editTitle, updateTitle)
    }

    func testUpdateButtonTouched() {
        // setup
        let reachCount = 6
        let targetCount = 6
        let title = "updateTitle"
        presenter.editReachCount = reachCount
        presenter.editTargetCount = targetCount
        presenter.editTitle = title

        // execute
        presenter.updateButtonTouched()

        // verify
        XCTAssertEqual(interactor.callCountUpdate, 1)
        XCTAssertEqual(task.title, title)
        XCTAssertEqual(task.reachCount, Int16(reachCount))
        XCTAssertEqual(task.targetCount, Int16(targetCount))
        XCTAssertEqual(view.callCountShowErrorAlert, 0)
    }

    func testFailedUpdateButtonTouched() {
        // setup
        presenter.editTitle = ""

        // execute
        presenter.updateButtonTouched()

        // verify
        XCTAssertEqual(interactor.callCountUpdate, 0)
        XCTAssertEqual(view.callCountShowErrorAlert, 1)
    }
}
