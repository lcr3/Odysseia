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
    var callCountViewDidLoad = 0
    var callCountLoadGoals = 0
    var callCountAddButtonTouched = 0
    var callCountGoalCellTouched = 0
    var callCountCellLongPress = 0
    var callCountSettingButtonTouched = 0

    func viewDidLoad() {
        callCountViewDidLoad += 1
    }

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

    func settingButtonTouched() {
        callCountSettingButtonTouched += 1
    }
}

class MockGoalListInteractor: GoalListUsecase {
    var output: GoalListInteractorOutput?
    var callCountLoadGoalList = 0

    func loadGoalList() {
        callCountLoadGoalList += 1
    }
}

class MockGoalListRouter: GoalListWireframe {
    var callCountShowDetail = 0
    var callCountShowAddGoal = 0
    var callCountShowSetting = 0
    var callCountShowDeleteAlert = 0
    var callCountShowTutorial = 0
    func showDetail(goal: Goal) {
        callCountShowDetail += 1
    }

    func showAddGoal() {
        callCountShowAddGoal += 1
    }

    func showSetting() {
        callCountShowSetting += 1
    }

    func showDeleteAlert(goal: Goal, output: GoalDeleteAlertPresenterOutput) {
        callCountShowDeleteAlert += 1
    }

    func showTutorial() {
        callCountShowTutorial += 1
    }

    var output: GoalListRouterOutput?
}
