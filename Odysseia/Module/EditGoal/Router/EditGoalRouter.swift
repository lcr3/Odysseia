//
//  EditGoalRouter.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//

import UIKit

protocol EditGoalWireframe: AnyObject {
    // Presenter -> Router
    func closeEditGoalView()
}

class EditGoalRouter {
    // 画面遷移のためにViewControllerが必要。initで受け取る
    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // DI
    static func assembleModules(editGoal: Goal) -> UIViewController {
        let view = EditGoalViewController.instantiate()
        let router = EditGoalRouter(viewController: view)
        let interector = EditGoalInteractor()
        // 生成し、initの引数で渡す
        let presenter = EditGoalPresenter(view: view,
                                          router: router,
                                          interactor: interector,
                                          editGoal: editGoal)
        view.presenter = presenter    // ViewにPresenterを設定
        interector.output = presenter

        return view
    }
}

extension EditGoalRouter: EditGoalWireframe {
    func closeEditGoalView() {
        viewController.dismiss(animated: true)
    }
}
