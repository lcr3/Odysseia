//
//  TutorialRouterTests.swift
//  Odysseia
//
//  Created by lcr on 14/11/2020.
//

@testable import Odysseia
import XCTest

class TutorialRouterTests: XCTestCase {
    var router: TutorialRouter!

    override func setUp() {
        super.setUp()
        let view = TutorialRouter.assembleModules()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController = view
            windowScene.windows.first?.makeKeyAndVisible()
        }
        router = TutorialRouter(viewController: view)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testShowGoalList() {
        // setup
        let exp = expectation(description: "testShowGoalList")

        // execute
        router.showGoalList()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let nav = windowScene.windows.first?.rootViewController as? GoalNavigationController

                // verify
                self.XCTxContext("GoalListに遷移していること") {
                    XCTAssertNotNil(nav?.topViewController as? GoalListViewController)
                }
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
}
