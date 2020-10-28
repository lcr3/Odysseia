//
//  AddTaskRouter.swift
//  Odysseia
//
//  Created by lcr on 27/10/2020.
//

import UIKit

protocol AddTaskWireframe: AnyObject {
    // Presenter -> Router
}

class AddTaskRouter {
    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules() -> UIViewController {
        let view = AddTaskViewController.instantiate()
        let router = AddTaskRouter(viewController: view)
        let interactor = AddTaskInteractor(service: GoalServicer.shared)
        let presenter = AddTaskPresenter(view: view,
                                         interactor: interactor,
                                         router: router)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

extension AddTaskRouter: AddTaskWireframe {
}
