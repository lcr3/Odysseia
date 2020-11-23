//
//  AddTaskPresenterTests.swift
//  Odysseia
//
//  Created by lcr on 27/10/2020.
//

@testable import Odysseia
import XCTest

class AddTaskPresenterTest: XCTestCase {
    var view: MockAddTaskView!
    var router: MockAddTaskRouter!
    var presenter: AddTaskPresenter!
    var interactor: MockAddTaskInteractor!

    override func setUp() {
        super.setUp()
        view = MockAddTaskView()
        router = MockAddTaskRouter()
        interactor = MockAddTaskInteractor()
        let goal = TemporaryGoal(title: "", detail: "", deadlineDate: Date())
        presenter = AddTaskPresenter(view: view, interactor: interactor, router: router, goal: goal)
    }

    override func tearDown() {
        super.tearDown()

    }

    func testFirstTutorial() {
        // setup
        let tc = TutorialConfigurator()
        tc.allClear()

        XCTAssertEqual(router.callCountShowTutorial, 0)
        XCTAssertFalse(tc.isComplete(type: .task))

        // execute
        presenter.viewDidLayoutSubviews()

        // verify
        XCTAssertEqual(router.callCountShowTutorial, 1)
        XCTAssertTrue(tc.isComplete(type: .task))
    }

    func testAlreadyTutorial() {
        // setup
        let tc = TutorialConfigurator()
        tc.allClear()
        tc.complete(type: .task)

        XCTAssertEqual(router.callCountShowTutorial, 0)
        XCTAssertTrue(tc.isComplete(type: .task))

        // execute
        presenter.viewDidLayoutSubviews()

        // verify
        XCTAssertEqual(router.callCountShowTutorial, 0)
        XCTAssertTrue(tc.isComplete(type: .task))
    }
}
