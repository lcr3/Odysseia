//
//  SupportPresenterTests.swift
//  Odysseia
//
//  Created by lcr on 03/12/2020.
//

@testable import Odysseia
import XCTest
import StoreKit

class SupportPresenterTest: XCTestCase {
    var view: MockSupportView!
    var router: MockSupportRouter!
    var interactor: MockSupportInteractor!
    var presenter: SupportPresenter!
    var keychainStore: MockKeychainStore!
    var output: MockSuppoutInteractorOutput!

    override func setUp() {
        super.setUp()
        view = MockSupportView()
        router = MockSupportRouter()
        interactor = MockSupportInteractor()
        keychainStore = MockKeychainStore()
        interactor.output = output
        presenter = SupportPresenter(view: view,
                                     router: router,
                                     interactor: interactor,
                                     keychainStore: keychainStore)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testViewDidLoad() {
        let testCases = [(isPurchase: false, expectCount: 0),
                        (isPurchase: true, expectCount: 1)]

        for testCase in testCases {
            // setup
            setUp()
            keychainStore.mockIsPurchase = testCase.isPurchase

            // execute
            presenter.viewDidLoad()

            // verify
            XCTAssertEqual(view.callCountAllredyPurchased, testCase.expectCount)

            // tearDown
            tearDown()
        }

    }

    func testPurchaseButtonTouched() {
        // execute
        presenter.purchaseButtonTouched()

        // verify
        XCTAssertEqual(interactor.callCountRequestProducts, 1)
    }

    func testRestoreButtonTouched() {
        // execute
        presenter.restoreButtonTouched()

        // verify
        XCTAssertEqual(interactor.callCountRestore, 1)
    }

    func testDeleteKeychainButtonTouched() {
        // execute
        presenter.deleteKeychainButtonTouched()

        // verify
        XCTAssertEqual(keychainStore.callCountDelete, 1)
    }

    func testFailed() {
        // setup
        let error = ProductClientError.canNotMakePayments

        // execute
        presenter.failed(error: error)

        // verify
        XCTAssertEqual(view.callCountError, 1)
        XCTAssertEqual(view.error?.localizedDescription, error.localizedDescription)
    }

    func testSuccessGet() {
        // execute
        presenter.successGet(product: SKProduct())

        // verify
        XCTAssertEqual(interactor.callCountPurchase, 1)
    }

    func testSuccessPurchase() {
        // execute
        presenter.successPurchase()

        // verify
        XCTAssertEqual(keychainStore.callCountSavePurchase, 1)
        XCTAssertEqual(view.callCountSuccess, 1)
        XCTAssertEqual(view.callCountAllredyPurchased, 1)
    }

    func testSuccessRestore() {
        // execute
        presenter.successRestore()

        // verify
        XCTAssertEqual(keychainStore.callCountSavePurchase, 1)
        XCTAssertEqual(view.callCountSuccess, 1)
        XCTAssertEqual(view.callCountAllredyPurchased, 1)
    }
}
