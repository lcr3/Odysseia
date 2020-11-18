//
//  AddGoalNameRouterTests.swift
//  Odysseia
//
//  Created by lcr on 27/10/2020.
//  Copyright © 2020 lcr. All rights reserved.
//

@testable import Odysseia
import XCTest

class AddGoalNameRouterTests: XCTestCase {
    var router: AddGoalNameRouter!

    override func setUp() {
        super.setUp()
        let view = AddGoalNameRouter.assembleModules()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController = GoalNavigationController(rootViewController: view)
            windowScene.windows.first?.makeKeyAndVisible()
        }
        router = AddGoalNameRouter(viewController: view)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSHowAddTask() {
        // setup
        let mockGoal = TemporaryGoal(title: "", detail: "", deadlineDate: Date())
        let exp = expectation(description: "testSHowAddTask")

        // execute
        router.showAddTask(goal: mockGoal)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            guard let main = mainWindow?.rootViewController as? GoalNavigationController else {
                XCTFail("UINavigationController not found")
                return
            }
            guard let addTaskViewController = main.topViewController as? AddTaskViewController else {
                XCTFail("SddTaskViewController not found")
                return
            }
            XCTAssertNotNil(addTaskViewController)
            exp.fulfill()
        }

        waitForExpectations(timeout: 3.0, handler: nil)
    }
}
