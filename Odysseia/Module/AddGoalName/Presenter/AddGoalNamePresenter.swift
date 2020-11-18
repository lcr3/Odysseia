//
//  AddGoalNamePresenter.swift
//  Odysseia
//
//  Created by lcr on 27/10/2020.
//

import Foundation

protocol AddGoalNamePresentation: AnyObject {
    // View -> Presenter
    func nextButtonTouched(title: String)
    func updateGoal(name: String)
    func updateDedline(year: Int)
    func validationError(msg: String)
}

class AddGoalNamePresenter {
    private weak var view: AddGoalNameView?
    private let router: AddGoalNameWireframe
    private let maxNameCount = 50
    private var deadlineYear: Int?

    init(view: AddGoalNameView,
         router: AddGoalNameWireframe) {
        self.view = view
        self.router = router
    }
}

extension AddGoalNamePresenter: AddGoalNamePresentation {
    func nextButtonTouched(title: String) {
        if title.isEmpty {
            validationError(msg: L10n.Localizable.goalTitleNilMsg)
            return
        }
        if title.count > maxNameCount {
            validationError(msg: L10n.Localizable.goalTitleMaxLengthMsg)
            return
        }
        guard let deadlineYear = deadlineYear else {
            validationError(msg: L10n.Localizable.deadlineYearNilMsg)
            return
        }
        guard let deadlineDate = Calendar.current.date(from: DateComponents(year: deadlineYear, month: 12, day: 31)) else {
            validationError(msg: L10n.Localizable.deadlineYearUnknownMsg)
            return
        }

        let goal = TemporaryGoal(title: title,
                                 detail: "",
                                 deadlineDate: deadlineDate)
        router.showAddTask(goal: goal)
    }

    func updateGoal(name: String) {
        if name.isEmpty || name.count > maxNameCount {
            view?.changeButton(enable: false)
        }
        view?.changeButton(enable: true)
    }

    func updateDedline(year: Int) {
        deadlineYear = year
    }

    func validationError(msg: String) {
        view?.validationError(msg: msg)
    }
}
