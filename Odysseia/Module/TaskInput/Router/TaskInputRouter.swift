//
//  TaskInputRouter.swift
//  Odysseia
//
//  Created by lcr on 10/11/2020.
//

import UIKit

protocol TaskInputWireframe: AnyObject {
    // Presenter -> Router
    func dismiss()
}

class TaskInputRouter {
    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules(output: TaskInputPresenterOutput) -> UIViewController {
        let view = TaskInputViewController.instantiate()
        let router = TaskInputRouter(viewController: view)
        let presenter = TaskInputPresenter(view: view,
                                           router: router,
                                           output: output)
        view.presenter = presenter
        return view
    }
}

extension TaskInputRouter: TaskInputWireframe {
    func dismiss() {
        viewController.dismiss(animated: true)
    }
}
