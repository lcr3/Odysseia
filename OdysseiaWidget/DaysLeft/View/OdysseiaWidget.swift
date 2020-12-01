//
//  OdysseiaWidget.swift
//  OdysseiaWidget
//
//  Created by lcr on 2020/11/27.
//

import SwiftUI
import WidgetKit

struct OdysseiaWidgetEntryView: View {
    // Widgetを更新するためのタイムラインを決定するオブジェクト
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color(Asset.astro.color)
            VStack(alignment: .center) {
                GoalTitleView(title: entry.title)
            }.padding(.top, 20)
            DaysLeftView(days: entry.leftdays)
        }
    }
}

struct OdysseiaWidget_Previews: PreviewProvider {
    static var previews: some View {
        OdysseiaWidgetEntryView(entry: Entry(date: Date(),
                                             configuration: ConfigurationIntent(),
                                             title: "目標をサポートする",
                                             leftdays: "256"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
