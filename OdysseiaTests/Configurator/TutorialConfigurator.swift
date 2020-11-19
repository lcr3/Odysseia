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
        let ud = UserDefaults.standard
        ud.dictionaryRepresentation().forEach {
            ud.removeObject(forKey: $0.key)
        }
        tutorialConfigurator = TutorialConfigurator()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testComplete() {
        // setup
        XCTAssertFalse(tutorialConfigurator.isComplete())

        // execute
        tutorialConfigurator.complete()

        // verify
        XCTAssertTrue(tutorialConfigurator.isComplete())
    }
}
