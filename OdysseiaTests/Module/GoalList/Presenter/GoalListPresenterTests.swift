//
//  GoalListPresenterTests.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/11/23.
//

@testable import Odysseia
import XCTest

class GoalListPresenterTests: XCTestCase {

    var view: MockGoalListView!
    var router: MockGoalListRouter!
    var presenter: GoalListPresenter!
    var interactor: MockGoalListInteractor!

    override func setUp() {
        super.setUp()
        view = MockGoalListView()
        router = MockGoalListRouter()
        interactor = MockGoalListInteractor()
        presenter = GoalListPresenter(view: view, router: router, interactor: interactor)
    }

    func testFirstTutorial() {
        // setup
        let tc = TutorialConfigurator()
        tc.allClear()

        XCTAssertEqual(router.callCountShowTutorial, 0)
        XCTAssertFalse(tc.isComplete(type: .goal))

        // execute
        presenter.viewDidLoad()

        // verify
        XCTAssertEqual(router.callCountShowTutorial, 1)
        XCTAssertTrue(tc.isComplete(type: .goal))
    }

    func testAlreadyTutorial() {
        // setup
        let tc = TutorialConfigurator()
        tc.allClear()
        tc.complete(type: .goal)

        XCTAssertEqual(router.callCountShowTutorial, 0)
        XCTAssertTrue(tc.isComplete(type: .goal))

        // execute
        presenter.viewDidLoad()

        // verify
        XCTAssertEqual(router.callCountShowTutorial, 0)
        XCTAssertTrue(tc.isComplete(type: .goal))
    }
}
