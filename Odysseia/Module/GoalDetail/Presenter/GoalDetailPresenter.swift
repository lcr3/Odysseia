//
//  GoalDetailPresenter.swift
//  Odysseia
//
//  Created by lcr on 2020/10/20.
//

protocol GoalDetailPresentation: AnyObject {
    var goal: Goal { get }

    // View -> Presenter
    func editButtonTouched()
    func taskTouched(index: Int)
    func loadGoal()
    func getAchievementRate() -> String
}

class GoalDetailPresenter {
    private weak var view: GoalDetailView?
    private let router: GoalDetailWireframe
    private let interactor: GoalDetailUsecase
    var goal: Goal

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

    func taskTouched(index: Int) {
        router.showEdit(task: goal.getTask(index: index), output: self)
    }

    func loadGoal() {
        interactor.loadGoalList(uuid: goal.id.uuidString)
    }

    func getAchievementRate() -> String {
        "\(goal.achievementRate())%"
    }
}

extension GoalDetailPresenter: GoalDetailInteractorOutput {
    func successLoad(goal: Goal) {
        self.goal = goal
        view?.updateViews()
    }

    func failedLoad(error: Error) {
    }
}

extension GoalDetailPresenter: EditTaskPresenterOutput {
    func successUpdete(task: Task) {
        loadGoal()
    }
}
