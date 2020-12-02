//
//  EditTaskRouterTests.swift
//  Odysseia
//
//  Created by lcr on 02/11/2020.
//

@testable import Odysseia
import XCTest

class EditTaskRouterTests: XCTestCase {
    var router: EditTaskRouter!
    var task: Task!
    var output: MockEditTaskPresenterOutput!

    override func setUp() {
        super.setUp()
        task = StubTask(title: "task",
                        reachCount: 3,
                        targetCount: 3)
        output = MockEditTaskPresenterOutput()
        let view = EditTaskRouter.assembleModules(task: task, output: output)
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overFullScreen
        view.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController = GoalNavigationController(rootViewController: view)
            windowScene.windows.first?.makeKeyAndVisible()
        }
        router = EditTaskRouter(viewController: view)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDismiss() {
        // setup
        let exp = expectation(description: "testDismiss")

        // execute
        router.dismiss()

        // verify
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            guard let main = mainWindow?.rootViewController as? GoalNavigationController else {
                XCTFail("UINavigationController not found")
                return
            }
            guard let editTaskViewController = main.topViewController as? EditTaskViewController else {
                XCTFail("EditTaskViewController not found")
                return
            }
            XCTAssertNotNil(editTaskViewController)
            exp.fulfill()
        }

        waitForExpectations(timeout: 3.0, handler: nil)

    }

}
