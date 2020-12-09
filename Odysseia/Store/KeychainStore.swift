//
//  KeychainStore.swift
//  Odysseia
//
//  Created by lcr on 2020/12/06.
//

import Foundation
import KeychainAccess

protocol KeychainStoreProtocol {
    func savePurchase()
    func isPurchase() -> Bool
    func delete()
}

class KeychainStore {
    static let shared = KeychainStore()
    let isPurchaseKey = "isPurchaseKey"
    var keychain: Keychain {
        guard let identifier = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String else { return Keychain(service: "") }
        return Keychain(service: identifier)
    }

    private init() {}
}

extension KeychainStore: KeychainStoreProtocol {
    func savePurchase() {
        try? keychain.set("true", key: isPurchaseKey)
    }

    func isPurchase() -> Bool {
        var resultString: String?
        do {
            resultString = try? keychain.get(isPurchaseKey)
        }
        guard let isPurchase = resultString, isPurchase == "true" else {
            return false
        }
        return true
    }

    func delete() {
        try? keychain.remove(isPurchaseKey)
    }
}
