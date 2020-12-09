//
//  SupportInteractorTests.swift
//  Odysseia
//
//  Created by lcr on 03/12/2020.
//

@testable import Odysseia
import XCTest
import StoreKit

class SupportInteractorTests: XCTestCase {
    var client: MockProductClient!
    var interactor: SupportInteractor!
    var output: MockSuppoutInteractorOutput!

    override func setUp() {
        super.setUp()
        output = MockSuppoutInteractorOutput()
        client = MockProductClient()
        interactor = SupportInteractor(client: client)
        interactor.output = output
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSuccessRequestProducts() {
        // setup
        client.canMakePayments = false

        // execute
        interactor.requestProducts()

        // verify
        XCTAssertEqual(output.callCountFailed, 1)
        XCTAssertEqual(client.callCountGetProducts, 0)
    }

    func testFailedRequestProducts() {
        // setup
        client.canMakePayments = true

        // execute
        interactor.requestProducts()

        // verify
        XCTAssertEqual(output.callCountFailed, 0)
        XCTAssertEqual(client.callCountGetProducts, 1)
    }

    func testPurchase() {
        // execute
        interactor.purchase(product: SKProduct())

        // verify
        XCTAssertEqual(client.callCountPurchase, 1)
    }

    func testRestore() {
        // execute
        interactor.restore()

        // verify
        XCTAssertEqual(client.callCountRestore, 1)
    }

    func testSuccessGet() {
        // execute
        interactor.successGet(product: SKProduct())

        // verify
        XCTAssertEqual(output.callCountSuccessGet, 1)
    }

    func testSuccessPurchase() {
        // execute
        interactor.successPurchase()

        // verify
        XCTAssertEqual(output.callCountSuccessPurchase, 1)
    }

    func testSuccessRestore() {
        // execute
        interactor.successRestore()

        // verify
        XCTAssertEqual(output.callCountSuccessPurchase, 1)
    }

    func testFailedGetProducts() {
        // execute
        interactor.failedGetProducts(error: ProductClientError.canNotMakePayments)

        // verify
        XCTAssertEqual(output.callCountFailed, 1)
    }

    func testFailedPurchased() {
        // execute
        interactor.failedGetProducts(error: ProductClientError.canNotMakePayments)

        // verify
        XCTAssertEqual(output.callCountFailed, 1)
    }
}
