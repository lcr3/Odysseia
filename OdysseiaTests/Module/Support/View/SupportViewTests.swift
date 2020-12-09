//
//  SupportViewTests.swift
//  Odysseia
//
//  Created by lcr on 03/12/2020.
//

@testable import Odysseia
import XCTest

class SupportViewTests: XCTestCase {
    var viewController: SupportViewController!
    var presenter: MockSupportPresenter!

    override func setUp() {
        super.setUp()
        presenter = MockSupportPresenter()
        viewController = SupportViewController.instantiate()
        viewController.presenter = presenter
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController = viewController
            windowScene.windows.first?.makeKeyAndVisible()
        }
    }

    override func tearDown() {
        super.tearDown()
    }

    func testViewDidload() {
        presenter.viewDidLoad()

        XCTAssertEqual(viewController.purchaseButton.titleLabel?.text, L10n.Localizable.donationMsg)
    }

    func testPurchaseButtonTouched() {
        // setup
        viewController.purchaseButtonTouched(UIButton())

        // verify
        XCTAssertEqual(presenter.callCountPurchaseButtonTouched, 1)
    }

    func testRestoreButtonTouched() {
        // setup
        viewController.restoreButtonTouched(UIBarButtonItem())

        // verify
        XCTAssertEqual(presenter.callCountRestoreButtonTouched, 1)
    }

    func testError() {
        // setup
        let expectTitle = L10n.Localizable.failedPurchasedTitle

        // execute
        viewController.error(error: ProductClientError.failedPurchased)
        delay(seconds: 2)

        // verify
        guard let alert = viewController.presentedViewController as? UIAlertController else {
            return XCTFail("Faild Get alert controller.")
        }
        XCTAssertEqual(alert.title, expectTitle)
    }

    func testSuccess() {
        // setup
        let expectTitle = L10n.Localizable.successPurchasedTitle

        // execute
        viewController.success()
        delay(seconds: 2)

        // verify
        guard let alert = viewController.presentedViewController as? UIAlertController else {
            return XCTFail("Faild Get alert controller.")
        }
        XCTAssertEqual(alert.title, expectTitle)
    }

    func testAllredyPurchased() {
        // setup
        let expectTitle = L10n.Localizable.alredyPurchasedMsg

        // execute
        viewController.allredyPurchased()
        delay(seconds: 2)

        // verify
        XCTAssertEqual(viewController.purchaseButton.titleLabel?.text, expectTitle)
    }
}
