//
//  GoalTitleView.swift
//  OdysseiaWidgetExtension
//
//  Created by lcr on 2020/11/30.
//

import SwiftUI

struct GoalTitleView: View {
    var title: String

    init(title: String) {
        self.title = title
    }

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            VStack(alignment: .leading) {
                Circle()
                    .stroke(Color(Asset.moon.color), lineWidth: 8)
                    .frame(width: 2, height: 2)
                Spacer()
            }.padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .black, design: .default))
                Spacer()
            }.padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 12))
        }
    }
}
