//
//  SupportViewController.swift
//  Odysseia
//
//  Created by lcr on 03/12/2020.
//

import UIKit

protocol SupportView: AnyObject {
    var presenter: SupportPresentation! { get }
    // View -> Presenter
    func viewDidLoad()
    // Presenter -> View
    func error(error: Error)
    func success()
    func allredyPurchased()
}

class SupportViewController: UIViewController, StoryboardInstantiatable {
    static var instantiateType: StoryboardInstantiateType { .initial }
    var presenter: SupportPresentation!
    @IBOutlet weak var purchaseButton: UIButton!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()

        let navItem = UIBarButtonItem(title: L10n.Localizable.restoreButtonTitle,
                                      style: .plain,
                                      target: self,
                                      action: #selector(restoreButtonTouched(_:)))
        navigationItem.rightBarButtonItems = [navItem]
    }

    @IBAction func purchaseButtonTouched(_ sender: Any) {
        presenter.purchaseButtonTouched()
    }

    @objc func restoreButtonTouched(_ sender: UIBarButtonItem) {
        presenter.restoreButtonTouched()
    }

    @IBAction private func deleteKeychainButtonTouched(_ sender: Any) {
        // debug only
        presenter.deleteKeychainButtonTouched()
    }
}

extension SupportViewController: SupportView {
    func error(error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: L10n.Localizable.failedPurchasedTitle,
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: L10n.Localizable.ok,
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func success() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: L10n.Localizable.successPurchasedTitle,
                                          message: nil,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: L10n.Localizable.ok,
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func allredyPurchased() {
        DispatchQueue.main.async {
            self.purchaseButton.setTitle(L10n.Localizable.alredyPurchasedMsg, for: .normal)
            self.purchaseButton.isEnabled = false
        }
    }
}
