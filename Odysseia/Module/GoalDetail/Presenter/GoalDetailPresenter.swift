//
//  GoalDetailPresenter.swift
//  Odysseial
//
//  Created by lcr on 2020/10/20.
//

protocol GoalDetailPresentation: AnyObject {
    var goal: Goal { get }

    func editButtonTouched()
    func loadGoal()
}

class GoalDetailPresenter {
    private weak var view: GoalDetailView?
    private let router: GoalDetailWireframe
    private let interactor: GoalDetailUsecase
    let goal: Goal

    init(view: GoalDetailView,
         router: GoalDetailWireframe,
         interactor: GoalDetailUsecase,
         goal: Goal) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.goal = goal
    }
}

extension GoalDetailPresenter: GoalDetailPresentation {
    func editButtonTouched() {
        router.showEdit(goal: goal)
    }

    func loadGoal() {

    }
}
