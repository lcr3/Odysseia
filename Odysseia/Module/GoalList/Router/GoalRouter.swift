//
//  GoalRouter.swift
//  CoreDataSample
//
//  Created by lcr on 2020/10/19.
//

import UIKit

protocol GoalListWireframe: AnyObject {
    func showDetail(goal: Goal)
    func showAddGoal()
}

class GoalListRouter {
    // 画面遷移のためにViewControllerが必要。initで受け取る
    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // DI
    static func assembleModules() -> UIViewController {
        let view = GoalListViewController.instantiate()
        let router = GoalListRouter(viewController: view)
        let interector = GoalListInteractor()
        // 生成し、initの引数で渡す
        let presenter = GoalListPresenter(view: view,
                                          router: router,
                                          interactor: interector)
        view.presenter = presenter    // ViewにPresenterを設定
        interector.output = presenter

        return view
    }
}

extension GoalListRouter: GoalListWireframe {
    func showDetail(goal: Goal) {
        let detailView = GoalDetailRouter.assembleModules(goal: goal)
        viewController.navigationController?.pushViewController(detailView, animated: true)
    }

    func showAddGoal() {
        let addGoalView = AddGoalRouter.assembleModules()
        let nav = UINavigationController(rootViewController: addGoalView)
        addGoalView.presentationController?.delegate = viewController as? UIAdaptivePresentationControllerDelegate
        viewController.navigationController?.present(nav, animated: true)
    }
}
