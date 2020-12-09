//
//  MockSupport.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/12/08.
//

@testable import Odysseia
import StoreKit

class MockSupportView: SupportView {
    var presenter: SupportPresentation!
    var callCountViewDidLoad = 0
    var callCountError = 0
    var callCountSuccess = 0
    var callCountAllredyPurchased = 0
    var error: Error?

    func viewDidLoad() {
        callCountViewDidLoad += 1
    }

    func error(error: Error) {
        callCountError += 1
        self.error = error
    }

    func success() {
        callCountSuccess += 1
    }

    func allredyPurchased() {
        callCountAllredyPurchased += 1
    }
}

class MockSupportPresenter: SupportPresentation {
    var callCountViewDidLoad = 0
    var callCountPurchaseButtonTouched = 0
    var callCountRestoreButtonTouched = 0
    var callCountDeleteKeychainButtonTouched = 0

    func viewDidLoad() {
        callCountViewDidLoad += 1
    }

    func purchaseButtonTouched() {
        callCountPurchaseButtonTouched += 1
    }

    func restoreButtonTouched() {
        callCountRestoreButtonTouched += 1
    }

    func deleteKeychainButtonTouched() {
        callCountDeleteKeychainButtonTouched += 1
    }
}

class MockSupportInteractor: SupportUsecase {
    var output: SupportInteractorOutput?
    var callCountRequestProducts = 0
    var callCountPurchase = 0
    var callCountRestore = 0
    var product: SKProduct?

    func requestProducts() {
        callCountRequestProducts += 1
    }

    func purchase(product: SKProduct) {
        callCountPurchase += 1
        self.product = product
    }

    func restore() {
        callCountRestore += 1
    }
}

class MockSupportRouter: SupportWireframe {
}

class MockSuppoutInteractorOutput: SupportInteractorOutput {
    var callCountSuccessGet = 0
    var callCountSuccessPurchase = 0
    var callCountFailed = 0

    func successGet(product: SKProduct) {
        callCountSuccessGet += 1
    }

    func successPurchase() {
        callCountSuccessPurchase += 1
    }

    func failed(error: Error) {
        callCountFailed += 1
    }
}

class MockProductClient: ProductClientProtocol {
    var output: ProductClientOutput?
    var canMakePayments = true

    var callCountGetProducts = 0
    var callCountPurchase = 0
    var callCountRestore = 0

    func getProducts() {
        callCountGetProducts += 1
    }

    func purchase(product: SKProduct) {
        callCountPurchase += 1
    }

    func restore() {
        callCountRestore += 1
    }
}
