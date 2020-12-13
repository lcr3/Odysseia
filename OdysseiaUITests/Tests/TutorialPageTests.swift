//
//  TutorialPageTests.swift
//  OdysseiaUITests
//
//  Created by lcr on 2020/12/11.
//

import XCTest

class TutorialPageTests: XCTestCase {
    let app = XCUIApplication()


    override func setUp() {
        continueAfterFailure = false
        app.launchArguments += [TestContainer.isTestingKey]
        app.launch()
    }

    override func tearDown() {
    }

    func testTutorial() {
        let goalListPage = TutorialPage(app: app)
            .swipeLeft()
            .swipeLeft()
            .tapStartButton()

        XCTAssertTrue(goalListPage.isDisplayGoalList())
    }
}
