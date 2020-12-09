//
//  SupportInteractor.swift
//  Odysseia
//
//  Created by lcr on 03/12/2020.
//
import StoreKit

protocol SupportUsecase: AnyObject {
    // Interactor -> Presenter
    var output: SupportInteractorOutput? { get }
    func requestProducts()
    func purchase(product: SKProduct)
    func restore()
}

class SupportInteractor {
    weak var output: SupportInteractorOutput?
    private let client: ProductClientProtocol

    init(client: ProductClientProtocol = ProductClient.shared) {
        self.client = client
        self.client.output = self
    }
}

extension SupportInteractor: SupportUsecase {
    func requestProducts() {
        if !client.canMakePayments {
            output?.failed(error: ProductClientError.canNotMakePayments)
            return
        }
        client.getProducts()
    }

    func purchase(product: SKProduct) {
        client.purchase(product: product)
    }

    func restore() {
        client.restore()
    }
}

extension SupportInteractor: ProductClientOutput {
    func successGet(product: SKProduct) {
        output?.successGet(product: product)
    }

    func successPurchase() {
        output?.successPurchase()
    }

    func successRestore() {
        output?.successPurchase()
    }

    func failedGetProducts(error: Error) {
        output?.failed(error: error)
    }

    func failedPurchased(error: Error) {
        output?.failed(error: error)
    }
}
