//
//  Provider.swift
//  OdysseiaWidgetExtension
//
//  Created by lcr on 2020/11/30.
//

import WidgetKit

struct Provider: IntentTimelineProvider {
    private let model: DayLeftModelProtocol

    init(service: GoalServiceProtocol = GoalServicer.shared) {
        self.model = DayLeftModel(service: service)
    }

    func placeholder(in context: Context) -> Entry {
        Entry(date: Date(),
              configuration: ConfigurationIntent(),
              title: L10n.Localizable.widgetSnapshotTitle,
              leftdays: L10n.Localizable.widgetSnapshotLeftDays)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Entry) -> Void) {
        let entry = Entry(date: Date(),
                          configuration: configuration,
                          title: L10n.Localizable.widgetSnapshotTitle,
                          leftdays: L10n.Localizable.widgetSnapshotLeftDays)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        // 1時間に1回更新する
        let refresh = Calendar.current.date(byAdding: Calendar.Component.hour, value: 1, to: Date()) ?? Date()
        let fetchGoalResult = model.fetchGoal(uuid: configuration.DayLeftType?.identifier)
        let entry = Entry(date: refresh, configuration: configuration, title: fetchGoalResult.title, leftdays: fetchGoalResult.daysLeft)
        let timeline = Timeline(entries: [entry], policy: .after(refresh))
        completion(timeline)
    }
}
