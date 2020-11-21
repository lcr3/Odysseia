//
//  SettingRouterTests.swift
//  Odysseia
//
//  Created by lcr on 19/11/2020.
//

@testable import Odysseia
import XCTest

class SettingRouterTests: XCTestCase {
    var router: SettingRouter!

    override func setUp() {
        super.setUp()
        let view = SettingRouter.assembleModules()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController = GoalNavigationController(rootViewController: view)
            windowScene.windows.first?.makeKeyAndVisible()
        }
        router = SettingRouter(viewController: view)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testShowAbout() {
        let exp = expectation(description: "testShowAbout")

        router.showAbout()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            guard let main = mainWindow?.rootViewController as? GoalNavigationController else {
                XCTFail("UINavigationController not found")
                return
            }
            guard let settingAboutViewController = main.topViewController as? SettingAboutViewController else {
                XCTFail("SettingAboutViewController not found")
                return
            }
            XCTAssertNotNil(settingAboutViewController)
            exp.fulfill()
        }

        waitForExpectations(timeout: 3.0, handler: nil)
    }
}
