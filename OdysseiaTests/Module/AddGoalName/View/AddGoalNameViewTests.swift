//
//  AddGoalNameiewTests.swift
//  Odysseia
//
//  Created by lcr on 27/10/2020.
//  Copyright © 2020 lcr. All rights reserved.
//

@testable import Odysseia
import XCTest

class AddGoalNameViewTests: XCTestCase {
    var addGoalNameViewController: AddGoalNameViewController!
    var presenter = MockAddGoalNamePresenter()

    override func setUp() {
        super.setUp()
        addGoalNameViewController = AddGoalNameViewController.instantiate()
        addGoalNameViewController.presenter = presenter
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController = addGoalNameViewController
            windowScene.windows.first?.makeKeyAndVisible()
        }
    }

    override func tearDown() {
        super.tearDown()
    }

    func testNextButtonTouched() {
        // execute
        addGoalNameViewController.nextButtonTouched(UIButton())

        // verify
        XCTAssertEqual(presenter.callCountNextButtonTouched, 1)
    }

    func testValidationError() {
        // setup
        let expectMsg = "test"

        // execute
        addGoalNameViewController.validationError(msg: expectMsg)

        guard let alert = addGoalNameViewController.presentedViewController as? UIAlertController else {
            return XCTFail("Faild Get alert controller.")
        }

        // verify
        XCTAssertEqual(alert.message, expectMsg)
    }
}
