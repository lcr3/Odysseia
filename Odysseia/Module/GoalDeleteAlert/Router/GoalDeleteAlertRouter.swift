//
//  GoalDeleteAlertRouter.swift
//  Odysseia
//
//  Created by lcr on 10/11/2020.
//

import UIKit

protocol GoalDeleteAlertWireframe: AnyObject {
    // Presenter -> Router
    func dismiss()
}

class GoalDeleteAlertRouter {
    private unowned let viewController: UIViewController
    private weak var output: GoalDeleteAlertPresenterOutput?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules(goal: Goal, output: GoalDeleteAlertPresenterOutput) -> UIViewController {
        let view = GoalDeleteAlertViewController.instantiate()
        let router = GoalDeleteAlertRouter(viewController: view)
        let interactor = GoalDeleteAlertInteractor(service: GoalServicer.shared)
        let presenter = GoalDeleteAlertPresenter(view: view,
                                                 router: router,
                                                 interactor: interactor,
                                                 goal: goal,
                                                 deleteOutput: output)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

extension GoalDeleteAlertRouter: GoalDeleteAlertWireframe {
    func dismiss() {
        viewController.dismiss(animated: true)
    }
}
