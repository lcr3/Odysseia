//
//  EditGoalPresenter.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//

import Foundation

protocol EditGoalPresentation: AnyObject {
    var editGoal: Goal { get }
    // View -> Presenter
    func doneButtonTouched(title: String, detail: String)
    func cancelButtonTouched()
}

class EditGoalPresenter {
    private weak var view: EditGoalView?
    private let router: EditGoalWireframe
    private let interactor: EditGoalUsecase
    let editGoal: Goal

    init(view: EditGoalView,
         router: EditGoalWireframe,
         interactor: EditGoalUsecase,
         editGoal: Goal) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.editGoal = editGoal
    }
}

extension EditGoalPresenter: EditGoalPresentation {
    func doneButtonTouched(title: String, detail: String) {
        // todo: バリデーションとか
        editGoal.title = title
        editGoal.detail = detail
        interactor.edit(goal: editGoal)
    }

    func cancelButtonTouched() {

    }
}

extension EditGoalPresenter: EditGoalInteractorOutput {
    func successEditGoal(goal: Goal) {
        router.closeEditGoalView()
    }

    func failedEditGoal(msg: String) {

    }
}
