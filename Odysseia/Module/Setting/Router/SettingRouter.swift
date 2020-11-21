//
//  SettingRouter.swift
//  Odysseia
//
//  Created by lcr on 19/11/2020.
//

import UIKit

protocol SettingWireframe: AnyObject {
    // Presenter -> Router
    func dismiss()
    func showAbout()
    func showSupport()
    func showSourceCord()
}

class SettingRouter {
    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules() -> UIViewController {
        let view = SettingViewController.instantiate()
        let router = SettingRouter(viewController: view)
        let presenter = SettingPresenter(view: view,
                                         router: router)
        view.presenter = presenter
        return view
    }
}

extension SettingRouter: SettingWireframe {
    func dismiss() {
        viewController.dismiss(animated: true, completion: nil)
    }

    func showAbout() {
        let settingAboutView = SettingAboutRouter.assembleModules()
        viewController.navigationController?.pushViewController(settingAboutView, animated: true)
    }

    func showSupport() {

    }

    func showSourceCord() {
        guard let url = URL(string: L10n.Localizable.sourceCordURL) else { return }
        UIApplication.shared.open(url)
    }
}
