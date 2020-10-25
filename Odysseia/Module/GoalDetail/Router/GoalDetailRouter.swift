//
//  GoalDetailRouter.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//

import UIKit

protocol GoalDetailWireframe: AnyObject {
    func showEdit(goal: Goal)
}

class GoalDetailRouter {
    // 画面遷移のためにViewControllerが必要。initで受け取る
    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // DI
    static func assembleModules(goal: Goal) -> UIViewController {
        let view = GoalDetailViewController.instantiate()
        let router = GoalDetailRouter(viewController: view)
        let interector = GoalDetailInteractor()
        // 生成し、initの引数で渡す
        let presenter = GoalDetailPresenter(view: view,
                                            router: router,
                                            interactor: interector,
                                            goal: goal)
        view.presenter = presenter
        interector.output = presenter
        return view
    }

}

extension GoalDetailRouter: GoalDetailWireframe {
    func showEdit(goal: Goal) {
        let editView = EditGoalRouter.assembleModules(editGoal: goal)
        let nav = GoalNavigationController(rootViewController: editView)
        editView.presentationController?.delegate = viewController as? UIAdaptivePresentationControllerDelegate
        viewController.navigationController?.present(nav, animated: true)
    }
}
