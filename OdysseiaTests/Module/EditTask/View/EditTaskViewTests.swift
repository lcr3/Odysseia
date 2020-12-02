//
//  EditTaskViewTests.swift
//  Odysseia
//
//  Created by lcr on 02/11/2020.
//

@testable import Odysseia
import XCTest

class EditTaskViewTests: XCTestCase {
    var editTaskViewController: EditTaskViewController!
    var presenter: MockEditTaskPresenter!

    override func setUp() {
        super.setUp()
        presenter = MockEditTaskPresenter()
        editTaskViewController = EditTaskViewController.instantiate()
        editTaskViewController.presenter = presenter
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController = editTaskViewController
            windowScene.windows.first?.makeKeyAndVisible()
        }
    }

    override func tearDown() {
        super.tearDown()
    }

    func testIncrementButtonTouched() {
        // execute
        editTaskViewController.incrementButtonTouched(UIButton())

        // verify
        XCTAssertEqual(presenter.callCountIncrementButtonTouched, 1)
    }

    func testDecrementButtonTouched() {
        // execute
        editTaskViewController.decrementButtonTouched(UIButton())

        // verify
        XCTAssertEqual(presenter.callCountDecrementButtonTouched, 1)
    }

    func testUpdateButtonTouched() {
        // execute
        editTaskViewController.updateButtonTouched(UIButton())
        editTaskViewController.titleField.text = "updateTitle"

        // verify
        XCTAssertEqual(presenter.callCountUpdateButtonTouched, 1)
    }
}
