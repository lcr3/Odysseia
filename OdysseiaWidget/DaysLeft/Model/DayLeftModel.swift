//
//  DayLeftModel.swift
//  OdysseiaWidgetExtension
//
//  Created by lcr on 2020/12/01.
//

protocol DayLeftModelProtocol {
    typealias FetchResult = (title: String, daysLeft: String)
    func fetchGoal(uuid: String?) -> FetchResult
}

final class DayLeftModel {
    private let service: GoalServiceProtocol
    private let failedFetchResult = (title: L10n.Localizable.failedFetchRequestTitle, daysLeft: "")

    init(service: GoalServiceProtocol = GoalServicer.shared) {
        self.service = service
    }
}

extension DayLeftModel: DayLeftModelProtocol {
    func fetchGoal(uuid: String?) -> FetchResult {
        if let uuid = uuid {
            return fetchGoal(uuid: uuid)
        }
        // Goalが指定されていない場合, 最新のGoalを取得
        return fetchFirstGoal()
    }

    private func fetchGoal(uuid: String) -> FetchResult {
        let goal: Goal
        do {
            goal = try service.get(uuid: uuid)
        } catch {
            return failedFetchResult
        }
        return (title: goal.title, daysLeft: String(goal.deadlineDays()))
    }

    private func fetchFirstGoal() -> FetchResult {
        let goals: [Goal]
        do {
            goals = try service.getAll()
        } catch {
            return failedFetchResult
        }
        guard let goal = goals.first else { return failedFetchResult }
        return (title: goal.title, daysLeft: String(goal.deadlineDays()))
    }
}
