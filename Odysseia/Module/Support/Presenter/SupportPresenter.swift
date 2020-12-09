//
//  SupportPresenter.swift
//  Odysseia
//
//  Created by lcr on 03/12/2020.
//
import StoreKit

protocol SupportPresentation: AnyObject {
    // View -> Presenter
    func viewDidLoad()
    func purchaseButtonTouched()
    func restoreButtonTouched()
    func deleteKeychainButtonTouched()
}

class SupportPresenter {
    private weak var view: SupportView?
    private let router: SupportWireframe
    private let interactor: SupportUsecase
    private let keychainStore: KeychainStoreProtocol

    init(view: SupportView,
         router: SupportWireframe,
         interactor: SupportUsecase,
         keychainStore: KeychainStoreProtocol = KeychainStore.shared) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.keychainStore = keychainStore
    }
}

extension SupportPresenter: SupportPresentation {
    func viewDidLoad() {
        if keychainStore.isPurchase() {
            view?.allredyPurchased()
        }
    }

    func purchaseButtonTouched() {
        interactor.requestProducts()
    }

    func restoreButtonTouched() {
        interactor.restore()
    }

    func deleteKeychainButtonTouched() {
        keychainStore.delete()
    }
}

extension SupportPresenter: SupportInteractorOutput {
    func failed(error: Error) {
        view?.error(error: error)
    }

    func successGet(product: SKProduct) {
        interactor.purchase(product: product)
    }

    func successPurchase() {
        keychainStore.savePurchase()
        view?.success()
        view?.allredyPurchased()
    }

    func successRestore() {
        keychainStore.savePurchase()
        view?.success()
        view?.allredyPurchased()
    }
}
