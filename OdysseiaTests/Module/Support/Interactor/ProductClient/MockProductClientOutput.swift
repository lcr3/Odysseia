//
//  MockProductClientOutput.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/12/08.
//

@testable import Odysseia
import StoreKit

class MockProductClientOutput: ProductClientOutput {
    var callCountSuccessGetProducts = 0
    var callCountSuccessPurchase = 0
    var callCountFailedGetProducts = 0
    var callCountFailedPurchased = 0
    var callCountSuccessRestore = 0
    var successGetProduct: SKProduct?
    var failedGetProductsError: Error?
    var failedPurchasedError: Error?

    func successGet(product: SKProduct) {
        callCountSuccessGetProducts += 1
        successGetProduct = product
    }

    func successPurchase() {
        callCountSuccessPurchase += 1
    }

    func successRestore() {
        callCountSuccessRestore += 1
    }

    func failedGetProducts(error: Error) {
        callCountFailedGetProducts += 1
        failedGetProductsError = error
    }

    func failedPurchased(error: Error) {
        callCountFailedPurchased += 1
        failedPurchasedError = error
    }
}

