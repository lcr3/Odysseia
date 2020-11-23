//
//  GoalListRouterTests.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/11/23.
//

@testable import Odysseia
import XCTest

class GoalListRouterTests: XCTestCase {

    var router: GoalListRouter!

    override func setUp() {
        super.setUp()
        let view = GoalListRouter.assembleModules()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController = GoalNavigationController(rootViewController: view)
            windowScene.windows.first?.makeKeyAndVisible()
        }
        router = GoalListRouter(viewController: view)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testShowSetting() {
        // setup
        let exp = expectation(description: "showSetting")

        // execute
        router.showSetting()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // verify
            guard let main = mainWindow?.rootViewController as? GoalNavigationController else {
                XCTFail("UINavigationController not found")
                return
            }

            guard let navViewController = main.presentedViewController as? GoalNavigationController, let settingViewController = navViewController.topViewController as? SettingViewController else {
                XCTFail("settingViewController not found")
                return
            }
            XCTAssertNotNil(settingViewController)
            exp.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }

    func testShowTutorial() {
        // setup
        let exp = expectation(description: "showTutorial")

        // execute
        router.showTutorial()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // verify
            guard let main = mainWindow?.rootViewController as? GoalNavigationController else {
                XCTFail("UINavigationController not found")
                return
            }

            guard let tutorialViewController = main.topViewController?.presentedViewController as? GoalListTutorialViewController else {
                XCTFail("tutorialViewController not found")
                return
            }
            XCTAssertNotNil(tutorialViewController)
            exp.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }

}
