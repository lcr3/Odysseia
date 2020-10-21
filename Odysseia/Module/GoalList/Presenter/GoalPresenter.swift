//
//  GoalPresenter.swift
//  CoreDataSample
//
//  Created by lcr on 2020/10/19.
//

protocol GoalListPresentation: AnyObject {
    var goals: [Goal] { get }
    // View -> Presenter
    func loadGoals()
    func addButtonTouched()
    func goalCellTouched(row: Int)
}

class GoalListPresenter {
    private weak var view: GoalListView?
    private let router: GoalListWireframe
    private let interactor: GoalListUsecase
    var goals: [Goal]

    init(view: GoalListView,
         router: GoalListWireframe,
         interactor: GoalListUsecase) {
        self.view = view
        self.router = router
        self.interactor = interactor
        goals = []
    }
}

extension GoalListPresenter: GoalListPresentation {
    func addButtonTouched() {
        router.showAddGoal()
    }
    func goalCellTouched(row: Int) {
        router.showDetail(goal: goals[row])
    }
    func loadGoals() {
        interactor.loadGoalList()
    }
}

extension GoalListPresenter: GoalListInteractorOutput {
    func failedLoad(error: Error) {
        print(error)
    }

    func successLoad(goals: [Goal]) {
        self.goals = goals
        view?.reload(goals: goals)
    }
}
