//
//  TutorialConfigurator.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/11/17.
//

@testable import Odysseia
import XCTest

class TutorialConfiguratorTests: XCTestCase {
    var tutorialConfigurator: TutorialConfigurator!

    override func setUp() {
        super.setUp()
        tutorialConfigurator = TutorialConfigurator()
        tutorialConfigurator.allClear()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testComplete() {
        // setup
        XCTAssertFalse(tutorialConfigurator.isComplete(type: .app))

        // execute
        tutorialConfigurator.complete(type: .app)

        // verify
        XCTAssertTrue(tutorialConfigurator.isComplete(type: .app))
    }

    func testAllClear() {
        // setup
        let tutorialTypes: [TutorialType] = [.app, .goal, .task]
        for type in tutorialTypes {
            tutorialConfigurator.complete(type: type)
        }

        // execute
        tutorialConfigurator.allClear()

        // verify
        for type in tutorialTypes {
            XCTAssertFalse(tutorialConfigurator.isComplete(type: type))
        }
    }
}
