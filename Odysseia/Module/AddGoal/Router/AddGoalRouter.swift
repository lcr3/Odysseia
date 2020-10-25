//
//  AddGoalRouter.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//

import UIKit

protocol AddGoalWireframe: AnyObject {
    // Presenter -> Router
    func closeAddGoalView()
}

class AddGoalRouter {
    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // DI
    static func assembleModules() -> UIViewController {
        let view = AddGoalViewController.instantiate()
        let router = AddGoalRouter(viewController: view)
        let interector = AddGoalInteractor(service: GoalServicer.shared)
        let presenter = AddGoalPresenter(view: view,
                                         router: router,
                                         interactor: interector)
        view.presenter = presenter
        interector.output = presenter
        return view
    }
}

extension AddGoalRouter: AddGoalWireframe {
    func closeAddGoalView() {
        viewController.dismiss(animated: true)
    }
}
