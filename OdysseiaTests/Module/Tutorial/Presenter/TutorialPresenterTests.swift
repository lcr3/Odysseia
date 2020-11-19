//
//  TutorialPresenterTests.swift
//  Odysseia
//
//  Created by lcr on 14/11/2020.
//

@testable import Odysseia
import XCTest

class TutorialPresenterTest: XCTestCase {

    var view: MockTutorialView!
    var router: MockTutorialRouter!
    var presenter: TutorialPresenter!

    override func setUp() {
        super.setUp()
        view = MockTutorialView()
        router = MockTutorialRouter()
        presenter = TutorialPresenter(view: view, router: router)
    }

    override func tearDown() {
        super.tearDown()
    }

    func test() {
        // execute
        presenter.startButtonTouched()

        XCTAssertEqual(router.callCountShowGoalList, 1)
    }
}
