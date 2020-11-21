//
//  SettingViewTests.swift
//  Odysseia
//
//  Created by lcr on 19/11/2020.
//

@testable import Odysseia
import XCTest

class SettingViewTests: XCTestCase {
    var settingViewController: SettingViewController!
    var presenter: MockSettingPresenter!

    override func setUp() {
        super.setUp()
        presenter = MockSettingPresenter()
        settingViewController = SettingViewController.instantiate()
        settingViewController.presenter = presenter
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController = settingViewController
            windowScene.windows.first?.makeKeyAndVisible()
        }
    }

    override func tearDown() {
        super.tearDown()
    }

    func testViewDidLoad() {
        // viewDidload
        XCTAssertEqual(presenter.callCountGetItems, 1)
    }

    func testTableViewDidSelect() {
        let testCases = [(row: 0, expectSettingRow: SettingRow.about),
                         (row: 1, expectSettingRow: SettingRow.support),
                         (row: 2, expectSettingRow: SettingRow.source)]

        for testCase in testCases {
            // setup
            setUp()
            let didselectRow = IndexPath(row: testCase.row, section: 0)

            // execute
            settingViewController.tableView(settingViewController.tableView, didSelectRowAt: didselectRow)

            // verify
            XCTAssertEqual(presenter.callCountCellTouched, 1)
            XCTAssertEqual(presenter.cellTouchedRow, testCase.expectSettingRow)

            // tearDown
            tearDown()
        }
    }
}
