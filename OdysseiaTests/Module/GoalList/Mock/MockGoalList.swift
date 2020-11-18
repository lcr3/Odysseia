//
//  MockGoalListView.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/11/13.
//

@testable import Odysseia

class MockGoalListView: GoalListView {
    var presenter: GoalListPresentation!
    var callCountViewDidLoad = 0
    var callCountReload = 0
    var callCountShowErrorMessageView = 0

    func viewDidLoad() {
        callCountViewDidLoad += 1
    }

    func reload(goals: [Goal]) {
        callCountViewDidLoad += 1
    }

    func showErrorMessageView(reason: String) {
        callCountShowErrorMessageView += 1
    }
}

class MockGoalListPresenter: GoalListPresentation {
    var goals: [Goal] = []
    var callCountLoadGoals = 0
    var callCountAddButtonTouched = 0
    var callCountGoalCellTouched = 0
    var callCountCellLongPress = 0
    func loadGoals() {
        callCountLoadGoals += 1
    }

    func addButtonTouched() {
        callCountAddButtonTouched += 1
    }

    func goalCellTouched(row: Int) {
        callCountGoalCellTouched += 1
    }

    func cellLongPress(row: Int) {
        callCountCellLongPress += 1
    }
}

class MockGoalListInteractor: GoalListUsecase {
    var output: GoalListInteractorOutput?
    var callCountLoadGoalList = 0

    func loadGoalList() {
        callCountLoadGoalList += 1
    }
}
