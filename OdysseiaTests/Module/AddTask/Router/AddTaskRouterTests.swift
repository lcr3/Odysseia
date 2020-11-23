//
//  AddTaskRouterTests.swift
//  Odysseia
//
//  Created by lcr on 27/10/2020.
//

@testable import Odysseia
import XCTest

class AddTaskRouterTests: XCTestCase {
    var router: AddTaskRouter!
    var mockGoal: TemporaryGoal!

    override func setUp() {
        super.setUp()
        let mockGoal = TemporaryGoal(title: "", detail: "", deadlineDate: Date())
        let view = AddTaskRouter.assembleModules(goal: mockGoal)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController = GoalNavigationController(rootViewController: view)
            windowScene.windows.first?.makeKeyAndVisible()
        }
        router = AddTaskRouter(viewController: view)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testShowTutorial() {
        // setup
        let exp = expectation(description: "testShowTutorial")

        // execute
        router.showTutorial(tutorialButtonFrame: CGRect(x: 0, y: 0, width: 0, height: 0))

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // verify
            guard let main = mainWindow?.rootViewController as? GoalNavigationController else {
                XCTFail("UINavigationController not found")
                return
            }

            guard let tutorialViewController = main.topViewController?.presentedViewController as? AddTaskTutorialViewController else {
                XCTFail("tutorialViewController not found")
                return
            }
            XCTAssertNotNil(tutorialViewController)
            exp.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
}
