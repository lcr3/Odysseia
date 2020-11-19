//
//  TutorialRouter.swift
//  Odysseia
//
//  Created by lcr on 14/11/2020.
//

import UIKit

protocol TutorialWireframe: AnyObject {
    // Presenter -> Router
    func showGoalList()
}

class TutorialRouter {
    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules() -> UIViewController {
        let view = TutorialViewController.instantiate()
        let router = TutorialRouter(viewController: view)
        let presenter = TutorialPresenter(view: view,
                                          router: router)
        view.presenter = presenter
        return view
    }
}

extension TutorialRouter: TutorialWireframe {
    func showGoalList() {
        let rootView = GoalListRouter.assembleModules()
        let nav = GoalNavigationController(rootViewController: rootView)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController = nav
            windowScene.windows.first?.makeKeyAndVisible()
        }
    }
}
