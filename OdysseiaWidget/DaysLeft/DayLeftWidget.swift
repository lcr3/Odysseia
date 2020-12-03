//
//  DayLeftWidget.swift
//  OdysseiaWidgetExtension
//
//  Created by lcr on 2020/11/30.
//

import SwiftUI
import WidgetKit

@main
struct OdysseiaWidget: Widget {
    let kind: String = "OdysseiaWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            OdysseiaWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(L10n.Localizable.widgetDisplayName)
        .description(L10n.Localizable.widgetDescription)
        .supportedFamilies([.systemSmall])
    }
}
