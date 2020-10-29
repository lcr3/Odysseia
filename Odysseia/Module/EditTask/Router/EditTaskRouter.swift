//
//  EditTaskRouter.swift
//  Odysseia
//
//  Created by lcr on 02/11/2020.
//

import UIKit

protocol EditTaskWireframe: AnyObject {
    // Presenter -> Router
    func dismiss()
}

class EditTaskRouter {
    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules(task: Task, output: EditTaskPresenterOutput) -> UIViewController {
        let view = EditTaskViewController.instantiate()
        let router = EditTaskRouter(viewController: view)
        let interector = EditTaskInteractor(service: GoalServicer.shared)
        let presenter = EditTaskPresenter(view: view,
                                          router: router,
                                          interactor: interector,
                                          task: task,
                                          output: output)
        view.presenter = presenter
        interector.output = presenter
        return view
    }
}

extension EditTaskRouter: EditTaskWireframe {
    func dismiss() {
        viewController.dismiss(animated: true)
    }
}
