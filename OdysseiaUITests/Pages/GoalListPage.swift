//
//  GoalListPage.swift
//  OdysseiaUITests
//
//  Created by lcr on 2020/12/13.
//

@testable import Odysseia
import XCTest

class GoalListPage: Page {
    var app: XCUIApplication
    private var title: XCUIElement { return app.staticTexts["GoalListTitle"] }

    required init(app: XCUIApplication) {
        self.app = app
    }

    func isDisplayGoalList() -> Bool {
        title.exists
    }
}
