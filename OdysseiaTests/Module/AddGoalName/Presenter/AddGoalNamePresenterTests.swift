//
//  AddGoalNamePresenterTests.swift
//  Odysseia
//
//  Created by lcr on 27/10/2020.
//  Copyright © 2020 lcr. All rights reserved.
//

@testable import Odysseia
import XCTest

class AddGoalNamePresenterTest: XCTestCase {

    var view: MockAddGoalNameView!
    var router: MockAddGoalNameRouter!
    var presenter: AddGoalNamePresenter!

    override func setUp() {
        super.setUp()
        view = MockAddGoalNameView()
        router = MockAddGoalNameRouter()
        presenter = AddGoalNamePresenter(view: view, router: router)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testValidationErrorTitle() {
        let testCases = [
            (title: "", errorMessage: L10n.Localizable.goalTitleNilMsg, callCount: 1),
            (title: createString(length: 50), errorMessage: "", callCount: 0),
            (title: createString(length: 51), errorMessage: L10n.Localizable.goalTitleMaxLengthMsg, callCount: 1)
        ]
        for testCase in testCases {
            // setup
            self.setUp()
            presenter.updateDedline(year: 2020)

            // execute
            presenter.nextButtonTouched(title: testCase.title)

            // verify
            XCTxContext("titleが空のときエラーが返ること") {
                XCTAssertEqual(view.callCountValidationError, testCase.callCount)
                XCTAssertEqual(view.validationErrorMsg, testCase.errorMessage)
            }

            // tearDown
            self.tearDown()
        }
    }

    private func createString(length: Int) -> String {
        let allowedChars = "a"
        var randomString = ""
        for _ in 0..<length {
            randomString += allowedChars
        }
        return randomString
    }
}
