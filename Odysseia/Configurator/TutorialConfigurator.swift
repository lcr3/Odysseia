//
//  TutorialConfigurator.swift
//  Odysseia
//
//  Created by lcr on 2020/11/14.
//

import Foundation

class TutorialConfigurator {
    private let key = "isCompleteTutorial"
    private let ud: UserDefaults

    init() {
        ud = UserDefaults.standard
    }

    func isComplete() -> Bool {
        ud.bool(forKey: key)
    }

    func complete() {
        ud.set(true, forKey: key)
    }
}
