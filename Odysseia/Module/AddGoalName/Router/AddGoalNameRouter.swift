//
//  AddGoalNameRouter.swift
//  Odysseia
//
//  Created by lcr on 27/10/2020.
//

import UIKit

protocol AddGoalNameWireframe: AnyObject {
    // Presenter -> Router
    func showAddTask(goal: TemporaryGoal)
}

class AddGoalNameRouter {
    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules() -> UIViewController {
        let view = AddGoalNameViewController.instantiate()
        let router = AddGoalNameRouter(viewController: view)
        let presenter = AddGoalNamePresenter(view: view,
                                             router: router)
        view.presenter = presenter
        return view
    }
}

extension AddGoalNameRouter: AddGoalNameWireframe {
    func showAddTask(goal: TemporaryGoal) {
        let addTaskView = AddTaskRouter.assembleModules(goal: goal)
        viewController.navigationController?.pushViewController(addTaskView, animated: true)
    }
}
