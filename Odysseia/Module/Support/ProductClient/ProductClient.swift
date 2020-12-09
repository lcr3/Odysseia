//
//  ProductClient.swift
//  Odysseia
//
//  Created by lcr on 2020/12/03.
//

import StoreKit

protocol ProductClientProtocol: AnyObject {
    var output: ProductClientOutput? { get set }
    var canMakePayments: Bool { get }
    func getProducts()
    func purchase(product: SKProduct)
    func restore()
}

final class ProductClient: NSObject {
    static let shared = ProductClient()
    weak var output: ProductClientOutput?
    var canMakePayments: Bool {
        SKPaymentQueue.canMakePayments()
    }
    // requestが開放されないように強参照する
    private var productsRequest: SKProductsRequest?
    private let productID = "com.lcr.Odysseia.donation"

    override private init () {}
}

extension ProductClient: ProductClientProtocol {
    func getProducts() {
        productsRequest = SKProductsRequest(productIdentifiers: [self.productID])
        productsRequest?.delegate = self
        productsRequest?.start()
    }

    func restore() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    func purchase(product: SKProduct) {
        if !canMakePayments {
            output?.failedPurchased(error: ProductClientError.failedPurchased)
            return
        }
        let transactions = SKPaymentQueue.default().transactions
        transactions.forEach { transaction in
            SKPaymentQueue.default().finishTransaction(transaction)
        }
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
        let payment = SKMutablePayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
}

extension ProductClient: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.isEmpty {
            output?.failedGetProducts(error: ProductClientError.noProduct)
            return
        }

        if !response.invalidProductIdentifiers.isEmpty {
            output?.failedGetProducts(error: ProductClientError.invalidProduct)
            return
        }

        for product in response.products where product.productIdentifier == productID {
            output?.successGet(product: product)
            return
        }
        output?.failedGetProducts(error: ProductClientError.noProduct)
    }
}

extension ProductClient: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        //課金状態が更新されるたびに呼ばれる
        transactions.forEach { transaction in
            print(transaction.transactionState.rawValue)
            switch transaction.transactionState {
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                output?.successPurchase()
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                guard let error = transaction.error else {
                    output?.failedPurchased(error: ProductClientError.failedPurchased)
                    break
                }
                output?.failedPurchased(error: error)
            case .restored:
                if transaction.transactionIdentifier == productID {
                    output?.successRestore()
                    return
                }
                output?.failedGetProducts(error: ProductClientError.failedRestore)
            case .deferred, .purchasing:
                break
            @unknown default:
                fatalError("unknown.")
            }
        }
    }

    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        output?.successRestore()
    }

    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        queue.transactions.forEach { transaction in
            SKPaymentQueue.default().finishTransaction(transaction)
        }
        output?.failedGetProducts(error: error)
    }
}
