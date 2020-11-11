//
//  GoalDeleteAlertPresenter.swift
//  Odysseia
//
//  Created by lcr on 10/11/2020.
//

protocol GoalDeleteAlertPresentation: AnyObject {
    // View -> Presenter
    func viewDidLoad()
    func positiveButtonTouched()
    func negativeButtonTouched()
}

class GoalDeleteAlertPresenter {
    private weak var view: GoalDeleteAlertView?
    private let router: GoalDeleteAlertWireframe
    private let interactor: GoalDeleteAlertUsecase
    private weak var deleteOutput: GoalDeleteAlertPresenterOutput?
    private var deleteGoal: Goal

    weak var output: GoalDeleteAlertInteractorOutput?

    init(view: GoalDeleteAlertView,
         router: GoalDeleteAlertWireframe,
         interactor: GoalDeleteAlertUsecase,
         goal: Goal,
         deleteOutput: GoalDeleteAlertPresenterOutput) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.deleteOutput = deleteOutput
        self.deleteGoal = goal
    }
}

extension GoalDeleteAlertPresenter: GoalDeleteAlertPresentation {
    func viewDidLoad() {
        view?.set(goal: deleteGoal)
    }

    func positiveButtonTouched() {
        interactor.deleteGoal(goal: deleteGoal)
    }

    func negativeButtonTouched() {
        router.dismiss()
    }
}

extension GoalDeleteAlertPresenter: GoalDeleteAlertInteractorOutput {
    func successDelete() {
        router.dismiss()
        deleteOutput?.successDeleteGoal()
    }

    func failedDelete(error: Error) {
        router.dismiss()
    }
}
