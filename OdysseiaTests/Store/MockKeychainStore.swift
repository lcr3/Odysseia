//
//  MockKeychainStore.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/12/08.
//

@testable import Odysseia

class MockKeychainStore: KeychainStoreProtocol {
    var callCountSavePurchase = 0
    var callCountIsPurchase = 0
    var callCountDelete = 0
    var mockIsPurchase = false

    func savePurchase() {
        callCountSavePurchase += 1
    }

    func isPurchase() -> Bool {
        callCountIsPurchase += 1
        return mockIsPurchase
    }

    func delete() {
        callCountDelete += 1
        mockIsPurchase = false
    }
}
