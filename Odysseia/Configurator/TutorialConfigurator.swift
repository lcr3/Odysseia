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
        ud.bool(forKey: type.rawValue)
    }

    func complete(type: TutorialType) {
        ud.set(true, forKey: type.rawValue)
    }

    func allClear() {
        ud.dictionaryRepresentation().forEach {
            ud.removeObject(forKey: $0.key)
        }
    }
}
