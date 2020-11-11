//
//  GoalDeleteAlertPresenterTests.swift
//  Odysseia
//
//  Created by lcr on 10/11/2020.
//

@testable import Odysseia
import XCTest

class GoalDeleteAlertPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockRouter: GoalDeleteAlertWireFrame {

    }

    class MockViewController: GoalDeleteAlertView {

        func setupInitialState() {

        }
    }
}
