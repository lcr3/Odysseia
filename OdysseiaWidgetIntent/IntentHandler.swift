//
//  IntentHandler.swift
//  OdysseiaWidgetIntent
//
//  Created by lcr on 2020/12/01.
//

import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        self
    }
}

extension IntentHandler: ConfigurationIntentHandling {
    func resolveDayLeftType(for intent: ConfigurationIntent, with completion: @escaping (DayLeftTypeResolutionResult) -> Void) {
    }

    func provideDayLeftTypeOptionsCollection(for intent: ConfigurationIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<DayLeftType>?, Error?) -> Void) {
        let allCatIdentifiers = INObjectCollection(items: getGoals())
        completion(allCatIdentifiers, nil)
    }

    private func getGoals() -> [DayLeftType] {
        let service = GoalServicer.shared
        var goals: [Goal]
        do {
            goals = try service.getAll()
            return goals
                .filter { !$0.isReach() }
                .compactMap {
                    DayLeftType(identifier: $0.id.uuidString, display: $0.title)
                }
        } catch {
            return []
        }
    }
}
