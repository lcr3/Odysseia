//
//  AddGoalNamePresenter.swift
//  Odysseia
//
//  Created by lcr on 27/10/2020.
//

protocol AddGoalNamePresentation: AnyObject {
    // View -> Presenter
    func nextButtonTouched()
    func updateGoal(name: String)
}

class AddGoalNamePresenter {
    private weak var view: AddGoalNameView?
    private let router: AddGoalNameWireframe
    private let maxNameCount = 50

    init(view: AddGoalNameView,
         router: AddGoalNameWireframe) {
        self.view = view
        self.router = router
    }
}

extension AddGoalNamePresenter: AddGoalNamePresentation {
    func nextButtonTouched() {
        router.showAddTask(name: "")
    }

    func updateGoal(name: String) {
        if name.isEmpty || name.count > maxNameCount {
            view?.changeButton(enable: false)
        }
        view?.changeButton(enable: true)
    }
}
