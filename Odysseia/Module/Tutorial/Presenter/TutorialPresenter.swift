//
//  TutorialPresenter.swift
//  Odysseia
//
//  Created by lcr on 14/11/2020.
//

protocol TutorialPresentation: AnyObject {
    // View -> Presenter
    func startButtonTouched()
}

class TutorialPresenter {
    private weak var view: TutorialView?
    private let router: TutorialWireframe
    private let configurator: TutorialConfigurator

    init(view: TutorialView,
         router: TutorialWireframe) {
        self.view = view
        self.router = router
        configurator = TutorialConfigurator()
    }
}

extension TutorialPresenter: TutorialPresentation {
    func startButtonTouched() {
        router.showGoalList()
        let notificationStore = NotificationStore()
        notificationStore.requestAuth()
        configurator.complete(type: .app)
    }
}
