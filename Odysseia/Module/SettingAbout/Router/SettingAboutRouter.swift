//
//  SettingAboutRouter.swift
//  Odysseia
//
//  Created by lcr on 20/11/2020.
//

import UIKit

protocol SettingAboutWireframe: AnyObject {
    // Presenter -> Router
    func showWeb(url: URL)
}

class SettingAboutRouter {
    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules() -> UIViewController {
        let view = SettingAboutViewController.instantiate()
        let router = SettingAboutRouter(viewController: view)
        let presenter = SettingAboutPresenter(view: view,
                                              router: router)
        view.presenter = presenter
        return view
    }
}

extension SettingAboutRouter: SettingAboutWireframe {
    func showWeb(url: URL) {
        UIApplication.shared.open(url)
    }
}
