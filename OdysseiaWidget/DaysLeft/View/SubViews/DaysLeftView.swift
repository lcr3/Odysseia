//
//  DaysLeftView.swift
//  OdysseiaWidgetExtension
//
//  Created by lcr on 2020/11/30.
//

import SwiftUI

struct DaysLeftView: View {
    var days: String

    init(days: String) {
        self.days = days
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: nil) {
            VStack {
                Spacer()
                Text(days)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.body)
            }
            VStack {
                Spacer()
                Text("Days")
                    .foregroundColor(.white)
            }
        }.padding(.bottom, 24)
    }
}
