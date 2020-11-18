//
//  GoalListViewTests.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/11/14.
//

@testable import Odysseia
import XCTest

class GoalListViewTests: XCTestCase {
    var goalListViewController: GoalListViewController!
    var presenter: MockGoalListPresenter!

    override func setUp() {
        super.setUp()
        presenter = MockGoalListPresenter()
        goalListViewController = GoalListViewController.instantiate()
        goalListViewController.presenter = presenter
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController = goalListViewController
            windowScene.windows.first?.makeKeyAndVisible()
        }
    }

    override func tearDown() {
        super.tearDown()
    }
}
