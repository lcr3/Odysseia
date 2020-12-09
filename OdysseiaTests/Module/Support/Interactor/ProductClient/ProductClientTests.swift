//
//  ProductClientTests.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/12/07.
//

@testable import Odysseia
import XCTest
import StoreKitTest

class ProductClientTests: XCTestCase {
    var client: ProductClient!
    var session: SKTestSession!
    var mockOutput: MockProductClientOutput?

    override func setUp() {
        super.setUp()
        client = ProductClient.shared
        mockOutput = MockProductClientOutput()
        client.output = mockOutput
        // 接続先をローカル環境に設定し、Configuration.storekitで設定した内容にアクセスするようにします
        session = try! SKTestSession(configurationFileNamed: "Configuration")
        // ダイアログを無効
        session.disableDialogs = true
        // 処理を失敗させるフラグ
        session.failTransactionsEnabled = false
        // 過去のトランザクションをすべて削除
        session.clearTransactions()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCanMakePayments() {
        XCTAssertTrue(client.canMakePayments)
    }

    func testGetProduct() {
        // execute
        client.getProducts()
        sleep(2)

        // verify
        XCTAssertEqual(mockOutput?.callCountSuccessGetProducts, 1)
        XCTAssertEqual(mockOutput?.successGetProduct?.productIdentifier, "com.lcr.Odysseia.donation")
    }

    func testFailedPurchase() {
        // setup
        session.failTransactionsEnabled = true
        client.getProducts()
        delay(seconds: 2)
        guard let product = mockOutput?.successGetProduct else {
            return XCTFail("Failed get product.")
        }

        // execute
        client.purchase(product: product)
        delay(seconds: 4)

        // verify
        XCTAssertEqual(mockOutput?.callCountFailedPurchased, 1)
        XCTAssertEqual(mockOutput?.callCountSuccessPurchase, 0)
        XCTAssertNotNil(mockOutput?.failedPurchasedError)
    }

    func testSuccessPurchase() {
        // setup
        client.getProducts()
        delay(seconds: 2)
        guard let product = mockOutput?.successGetProduct else {
            return XCTFail("Failed get product.")
        }

        // execute
        client.purchase(product: product)
        delay(seconds: 4)

        // verify
        XCTAssertEqual(mockOutput?.callCountFailedPurchased, 0)
        XCTAssertEqual(mockOutput?.callCountSuccessPurchase, 1)
        XCTAssertNil(mockOutput?.failedPurchasedError)
    }
}
