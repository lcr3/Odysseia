//
//  AddGoalRouter.swift
//  Odysseial
//
//  Created by lcr on 2020/10/20.
//

import UIKit

protocol AddGoalWireframe: AnyObject {
    //    func showDetail()
    //    func showSiginupView()
    //    func showResetPasswordView()
    // Presenter -> Router
    func closeAddGoalView()
}

class AddGoalRouter {
    // 画面遷移のためにViewControllerが必要。initで受け取る
    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // DI
    static func assembleModules() -> UIViewController {
        let view = AddGoalViewController.instantiate()
        let router = AddGoalRouter(viewController: view)
        let interector = AddGoalInteractor()
        // 生成し、initの引数で渡す
        let presenter = AddGoalPresenter(view: view,
                                         router: router,
                                         interactor: interector)
        view.presenter = presenter    // ViewにPresenterを設定
        interector.output = presenter

        return view
    }
}

extension AddGoalRouter: AddGoalWireframe {
    func closeAddGoalView() {
        viewController.dismiss(animated: true)
    }
}
