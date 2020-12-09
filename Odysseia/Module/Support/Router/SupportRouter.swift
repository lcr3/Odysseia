//
//  SupportRouter.swift
//  Odysseia
//
//  Created by lcr on 03/12/2020.
//

import UIKit

protocol SupportWireframe: AnyObject {
    // Presenter -> Router
}

class SupportRouter {
    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules() -> UIViewController {
        let view = SupportViewController.instantiate()
        let router = SupportRouter(viewController: view)
        let interector = SupportInteractor()
        let presenter = SupportPresenter(view: view,
                                         router: router,
                                         interactor: interector)
        view.presenter = presenter
        interector.output = presenter
        return view
    }
}

extension SupportRouter: SupportWireframe {
}
