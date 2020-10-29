//
//  GoalRouter.swift
//  Odysseia
//
//  Created by lcr on 2020/10/19.
//

import UIKit

protocol GoalListWireframe: AnyObject {
    func showDetail(goal: Goal)
    func showAddGoal()

    var output: GoalListRouterOutput? { get }
}

class GoalListRouter {
    private unowned let viewController: UIViewController
    weak var output: GoalListRouterOutput?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules() -> UIViewController {
        let view = GoalListViewController.instantiate()
        let router = GoalListRouter(viewController: view)
        let interector = GoalListInteractor()
        let presenter = GoalListPresenter(view: view,
                                          router: router,
                                          interactor: interector)
        view.presenter = presenter
        interector.output = presenter
        router.output = presenter
        return view
    }
}

extension GoalListRouter: GoalListWireframe {
    func showDetail(goal: Goal) {
        let detailView = GoalDetailRouter.assembleModules(goal: goal)
        viewController.navigationController?.pushViewController(detailView, animated: true)
    }

    func showAddGoal() {
        let addGoalView = AddGoalNameRouter.assembleModules()
        let nav = AddGoalNavigationController(rootVc: addGoalView, delegate: self)
        viewController.navigationController?.present(nav, animated: true)
    }
}

extension GoalListRouter: AddGoalDelegate {
    // Success add goal notification.
    func successAddGoal() {
        output?.successAddGoal()
    }
}
