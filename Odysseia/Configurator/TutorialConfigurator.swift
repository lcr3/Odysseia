//
//  TutorialConfigurator.swift
//  Odysseia
//
//  Created by lcr on 2020/11/14.
//

import Foundation

enum TutorialType: String {
    case app = "appTutorial"
    case goal = "addGoalTutorial"
    case task = "addTaskTutorial"
}

class TutorialConfigurator {
    private let ud: UserDefaults

    init() {
        ud = UserDefaults.standard
    }

    func isComplete(type: TutorialType) -> Bool {
        let testContainer = getTestContainer()
        if testContainer.isTesting {
            return testContainer.isSkipTutorial
        }
        return ud.bool(forKey: type.rawValue)
    }

    func complete(type: TutorialType) {
        ud.set(true, forKey: type.rawValue)
    }

    func allClear() {
        ud.dictionaryRepresentation().forEach {
            ud.removeObject(forKey: $0.key)
        }
    }

    func getTestContainer() -> TestContainer {
        let isUITesting = ProcessInfo.processInfo.arguments.contains(TestContainer.isTestingKey)
        let isSkipTurorial = ProcessInfo.processInfo.arguments.contains(TestContainer.isSkipTutorialKey)
        return TestContainer(isTesting: isUITesting, isSkipTutorial: isSkipTurorial)
    }
}

// UITest用の設定
struct TestContainer {
    static let isTestingKey = "is-ui-testing"
    static let isSkipTutorialKey = "skip-tutorial"

    let isTesting: Bool
    let isSkipTutorial: Bool
}
