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
    // ViewModel
    @ObservedObject var model: WidgetViewModel
    init(entry: Entry) {
        self.model = WidgetViewModel()
        self.entry = entry
    }

    var body: some View {
        ZStack {
            Color(Asset.astro.color)
            VStack(alignment: .center) {
                GoalTitleView(title: model.goalTitle)
            }.padding(.top, 20)
            DaysLeftView(days: model.daysLeft)
        }
        .onAppear(perform: model.onAppear )
    }
}

struct OdysseiaWidget_Previews: PreviewProvider {
    static var previews: some View {
        OdysseiaWidgetEntryView(entry: Entry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
