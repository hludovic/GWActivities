//
//  DayActivitiesView.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 09/06/2023.
//

import SwiftUI

struct DayActivitiesView: View {
    @Binding var selectedTable: DayActivity.ID?
    @Binding var content: [DayActivity]?

    var body: some View {
        if let content, content.count != 0 {
            VStack {
                Table(content, selection: $selectedTable) {
                    TableColumn("Date", value: \.dateString)
                        .width(min: 45, ideal: 100)
                    TableColumn("Zaishen Mission", value: \.zaishen_mission.title)
                        .width(min: 90, ideal: 100)
                    TableColumn("Zaishen Bounty", value: \.zaishen_bounty.title)
                        .width(min: 90, ideal: 100)
                    TableColumn("Zaishen Combat", value: \.zaishen_combat.title)
                        .width(min: 90, ideal: 100)
                    TableColumn("Zaishen Vanquish", value: \.zaishen_vanquish.title)
                        .width(min: 90, ideal: 100)
                    TableColumn("Shining Blade", value: \.shining_blade.title)
                        .width(min: 90, ideal: 100)
                    TableColumn("Vanguard Quest", value: \.vanguard_quest.title)
                        .width(min: 90, ideal: 100)
                    TableColumn("Nicholas Sandford", value: \.nicholas_sandford.title)
                        .width(min: 90, ideal: 100)
                }
                .frame(minWidth: 550, maxHeight: .infinity)
                HStack {
                    Text("\(content.count) activities found")
                        .font(.caption)
                        .padding(.bottom, 5)
                }
            }
        } else {
            Text("Refresh")
        }
    }
}

struct DayActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        DayActivitiesView(selectedTable: .constant(nil), content: .constant(PreviewMockedData.activities))
    }
}
