//
//  AddGoalNamePresenterTests.swift
//  Odysseia
//
//  Created by lcr on 27/10/2020.
//  Copyright © 2020 lcr. All rights reserved.
//

import XCTest

class AddGoalNamePresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockRouter: AddGoalNameRouter {

    }

    class MockViewController: AddGoalNameView {

        func setupInitialState() {

        }
    }
}
