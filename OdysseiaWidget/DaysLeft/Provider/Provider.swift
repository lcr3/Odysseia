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
        var entries: [Entry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let fetchGoalResult = model.fetchGoal(uuid: configuration.DayLeftType?.identifier)
            let entry = Entry(date: entryDate, configuration: configuration, title: fetchGoalResult.title, leftdays: fetchGoalResult.daysLeft)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
