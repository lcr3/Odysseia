//
//  ProductClientOutput.swift
//  Odysseia
//
//  Created by lcr on 2020/12/07.
//

import StoreKit

protocol ProductClientOutput: AnyObject {
    func successGet(product: SKProduct)
    func successPurchase()
    func successRestore()
    func failedGetProducts(error: Error)
    func failedPurchased(error: Error)
}
