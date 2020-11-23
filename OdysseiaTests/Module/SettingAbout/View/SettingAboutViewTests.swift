//
//  SettingAboutViewTests.swift
//  Odysseia
//
//  Created by lcr on 20/11/2020.
//

@testable import Odysseia
import XCTest

class SettingAboutViewTests: XCTestCase {
    var viewController: SettingAboutViewController!
    var presenter: MockSettingAboutPresenter!

    override func setUp() {
        super.setUp()
        presenter = MockSettingAboutPresenter()
        viewController = SettingAboutViewController.instantiate()
        viewController.presenter = presenter
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController = viewController
            windowScene.windows.first?.makeKeyAndVisible()
        }
    }

    override func tearDown() {
        super.tearDown()
    }

    func testViewDidLoad() {
        // viewDidLoad
        XCTAssertEqual(presenter.callCountViewDidLoad, 1)
        XCTAssertEqual(presenter.callCountGetItems, 1)
        XCTAssertEqual(viewController.tableView.visibleCells.count, 2)
    }

    func testDidSelectRow() {
        // setup
        let didSelectRow = IndexPath(row: 0, section: 0)

        // execute
        viewController.tableView(viewController.tableView, didSelectRowAt: didSelectRow)

        // verify
        XCTAssertEqual(presenter.callCountCallTouched, 1)
        XCTAssertEqual(presenter.row, didSelectRow.row)
    }
}
