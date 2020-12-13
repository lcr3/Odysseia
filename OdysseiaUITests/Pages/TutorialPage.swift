//
//  TutorialPage.swift
//  OdysseiaUITests
//
//  Created by lcr on 2020/12/11.
//

@testable import Odysseia
import XCTest

class TutorialPage: Page {
    var app: XCUIApplication

    private var startButton: XCUIElement { return app.buttons["StartButton"] }

    required init(app: XCUIApplication) {
        self.app = app
    }

    func swipeRight() -> TutorialPage {
        app.swipeRight()
        return self
    }

    func swipeLeft() -> TutorialPage {
        app.swipeLeft()
        return self
    }

    func tapStartButton() -> GoalListPage {
        startButton.tap()
        return GoalListPage(app: app)
    }
}
