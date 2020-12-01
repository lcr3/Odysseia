//
//  OdysseiaWidgetEntryPresenter.swift
//  OdysseiaWidgetExtension
//
//  Created by lcr on 2020/11/30.
//

import Foundation

final class WidgetViewModel: ObservableObject {
    private let service: GoalServiceProtocol
    @Published var goalTitle: String
    @Published var daysLeft: String

    init(service: GoalServicer = GoalServicer.shared) {
        self.service = service
        self.goalTitle = "Loading..."
        self.daysLeft = "---"
    }

    func onAppear() {
        fetchAll()
    }

    func fetchAll() {
        let goals: [Goal]
        do {
            goals = try service.getAll()
        } catch {
            goalTitle = "Load error."
            return
        }
        guard let goal = goals.first else { return }

        goalTitle = goal.title
        daysLeft = String(goal.deadlineDays())
    }
}
