//
//  MockTutorial.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/11/19.
//

@testable import Odysseia

class MockTutorialView: TutorialView {
    var presenter: TutorialPresentation!
}

class MockTutorialPresenter: TutorialPresentation {
    var callCountStartButtonTouched = 0

    func startButtonTouched() {
        callCountStartButtonTouched += 1
    }
}

class MockTutorialRouter: TutorialWireframe {
    var callCountShowGoalList = 0
    func showGoalList() {
        callCountShowGoalList += 1
    }
}
