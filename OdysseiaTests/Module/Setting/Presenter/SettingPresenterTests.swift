//
//  SettingPresenterTests.swift
//  Odysseia
//
//  Created by lcr on 19/11/2020.
//

@testable import Odysseia
import XCTest

class SettingPresenterTest: XCTestCase {
    var view: MockSettingView!
    var router: MockSettingRouter!
    var presenter: SettingPresenter!

    override func setUp() {
        super.setUp()
        view = MockSettingView()
        router = MockSettingRouter()
        presenter = SettingPresenter(view: view, router: router)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testShowAbout() {
        // setUp
        let settingRow = SettingRow.about

        // execute
        presenter.cellTouched(row: settingRow)

        // verify
        XCTAssertEqual(router.callCountShowAbout, 1)
        XCTAssertEqual(router.callCountShowSupport, 0)
        XCTAssertEqual(router.callCountShowSourceCord, 0)
    }

    func testShowSupport() {
        // setUp
        let settingRow = SettingRow.support

        // execute
        presenter.cellTouched(row: settingRow)

        // verify
        XCTAssertEqual(router.callCountShowAbout, 0)
        XCTAssertEqual(router.callCountShowSupport, 1)
        XCTAssertEqual(router.callCountShowSourceCord, 0)
    }

    func testShowSource() {
        // setUp
        let settingRow = SettingRow.source

        // execute
        presenter.cellTouched(row: settingRow)

        // verify
        XCTAssertEqual(router.callCountShowAbout, 0)
        XCTAssertEqual(router.callCountShowSupport, 0)
        XCTAssertEqual(router.callCountShowSourceCord, 1)
    }

    func testGetItems() {
        // setup
        let expectItems = SettingPresenter.createItems()

        // execute
        let getItems = presenter.getItems()

        // verify
        for (index, item) in getItems.enumerated() {
            let expectItem = expectItems[index]
            XCTAssertEqual(item.title, expectItem.title)
            XCTAssertEqual(item.image, expectItem.image)
            XCTAssertEqual(item.row, expectItem.row)
        }
    }
}
