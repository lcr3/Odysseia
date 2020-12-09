//
//  SupportInteractorOutput.swift
//  Odysseia
//
//  Created by lcr on 03/12/2020.
//

import StoreKit

protocol SupportInteractorOutput: AnyObject {
    // Interactor -> Output
    func successGet(product: SKProduct)
    func successPurchase()
    func failed(error: Error)
}
