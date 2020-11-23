//
//  AddTaskRouter.swift
//  Odysseia
//
//  Created by lcr on 27/10/2020.
//

import UIKit

protocol AddTaskWireframe: AnyObject {
    // Presenter -> Router
    func showTutorial(tutorialButtonFrame: CGRect)
    func dismiss()
    func back()
    func showAddTaskInput(outut: TaskInputPresenterOutput)
}

class AddTaskRouter {
    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules(goal: TemporaryGoal) -> UIViewController {
        let view = AddTaskViewController.instantiate()
        let router = AddTaskRouter(viewController: view)
        let interactor = AddTaskInteractor(service: GoalServicer.shared)
        let presenter = AddTaskPresenter(view: view,
                                         interactor: interactor,
                                         router: router,
                                         goal: goal)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

extension AddTaskRouter: AddTaskWireframe {
    func dismiss() {
        guard let addGoalNav = viewController.navigationController as? AddGoalNavigationController else {
            return
        }
        addGoalNav.dismissSuccessAddGoal()
    }

    func back() {
        viewController.navigationController?.popViewController(animated: true)
    }

    func showAddTaskInput(outut: TaskInputPresenterOutput) {
        let addTaskInputView = TaskInputRouter.assembleModules(output: outut)
        addTaskInputView.modalTransitionStyle = .crossDissolve
        addTaskInputView.modalPresentationStyle = .overFullScreen
        addTaskInputView.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        viewController.present(addTaskInputView, animated: true)
    }

    func showTutorial(tutorialButtonFrame: CGRect) {
        let spotlightViewController = AddTaskTutorialViewController()
        viewController.navigationController?.present(spotlightViewController, animated: true) {
            spotlightViewController.start(frame: tutorialButtonFrame)
        }
    }
}
