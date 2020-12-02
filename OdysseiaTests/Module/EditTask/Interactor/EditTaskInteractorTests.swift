//
//  EditTaskInteractorTests.swift
//  Odysseia
//
//  Created by lcr on 02/11/2020.
//
@testable import Odysseia
import XCTest

class EditTaskInteractorTests: XCTestCase {
    var service: MockGoalService!
    var interactor: EditTaskInteractor!
    var output: MockEditTaskInteractorOutput!

    override func setUp() {
        super.setUp()
        service = MockGoalService()
        output = MockEditTaskInteractorOutput()
        interactor = EditTaskInteractor(service: service)
        interactor.output = output
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSuccessUpdate() {
        // setup
        let task = StubTask(title: "task",
                            reachCount: 4,
                            targetCount: 6)

        // execute
        interactor.update(task: task)

        // verify
        XCTAssertEqual(output.callCountSccessUpdate, 1)
        XCTAssertEqual(service.callCountUpdateTask, 1)
    }

    func testFailedUpdate() {
        // setup
        let task = StubTask(title: "task",
                            reachCount: 4,
                            targetCount: 6)
        service.isSuccessUpdateTask = false

        // execute
        interactor.update(task: task)

        // verify
        XCTAssertEqual(output.callCountFaildUpdate, 1)
        XCTAssertEqual(service.callCountUpdateTask, 1)
    }
}
