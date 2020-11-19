//
//  TutorialViewTests.swift
//  Odysseia
//
//  Created by lcr on 14/11/2020.
//

@testable import Odysseia
import XCTest

class TutorialViewTests: XCTestCase {

    var tutorialViewController: TutorialViewController!
    var presenter = MockTutorialPresenter()

    override func setUp() {
        super.setUp()
        tutorialViewController = TutorialViewController.instantiate()
        tutorialViewController.presenter = presenter
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController = tutorialViewController
            windowScene.windows.first?.makeKeyAndVisible()
        }
    }

    override func tearDown() {
        super.tearDown()
    }

    func testStartButtonTouched() {
        // execute
        tutorialViewController.startButtonTouched()

        // verify
        XCTAssertEqual(presenter.callCountStartButtonTouched, 1)
    }

    func testScrollPage() {
        // setup
        let index = 2
        let transitionViewController = tutorialViewController.pages[index]

        // execute
        tutorialViewController.setViewControllers([transitionViewController],
                                                  direction: .forward,
                                                  animated: false,
                                                  completion: nil)

        // verify
        let displayViewController = tutorialViewController.viewControllers?.first as? ThirdViewController
        XCTAssertNotNil(displayViewController)
    }
}
