//
//  AddGoalPresenter.swift
//  Odysseial
//
//  Created by lcr on 2020/10/20.
//

import Foundation

protocol AddGoalPresentation: AnyObject {
    // View -> Presenter
    func addButtonTouched(title: String, detail: String)
    func cancelButtonTouched()
}

class AddGoalPresenter {
    private weak var view: AddGoalView?
    private let router: AddGoalWireframe
    private let interactor: AddGoalUsecase

    init(view: AddGoalView,
         router: AddGoalWireframe,
         interactor: AddGoalUsecase) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension AddGoalPresenter: AddGoalPresentation {
    func addButtonTouched(title: String, detail: String) {
        // todo: バリデーションとか
        let goal = TemporaryGoal(title: title, detail: detail)
        interactor.addGoal(goal: goal)
    }

    func cancelButtonTouched() {

    }
}

extension AddGoalPresenter: AddGoalInteractorOutput {
    func successAddGoal(goal: Goal) {
        router.closeAddGoalView()
    }

    func failedAddGoal(msg: String) {

    }
}
