//
//  SettingAboutPresenterTests.swift
//  Odysseia
//
//  Created by lcr on 20/11/2020.
//

@testable import Odysseia
import XCTest

class SettingAboutPresenterTest: XCTestCase {
    var view: MockSettingAboutView!
    var router: MockSettingAboutRouter!
    var presenter: SettingAboutPresenter!

    override func setUp() {
        super.setUp()
        view = MockSettingAboutView()
        router = MockSettingAboutRouter()
        presenter = SettingAboutPresenter(view: view, router: router)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testShowWeb() {
        // execute
        presenter.cellTouched(row: 0)

        // verify
        XCTAssertEqual(router.callCountShowWeb, 1)
    }

    func testGetItems() {
        // setup
        let expectLibraries = [(title: L10n.Localizable.geccoTitle, link:  L10n.Localizable.geccoLink),
                         (title: L10n.Localizable.hgCircularSliderTitle, link: L10n.Localizable.hgCircularSliderLink),
                         (title: L10n.Localizable.keychainAccessTitle, link: L10n.Localizable.keychainAccessLink)
        ]

        // execute
        let items = presenter.getItems()

        // verify
        for (index, item) in items.enumerated() {
            let expectItem = expectLibraries[index]
            XCTAssertEqual(item.title, expectItem.title)
            XCTAssertEqual(item.link, expectItem.link)
        }
    }
}
