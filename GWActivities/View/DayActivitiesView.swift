//
//  DayActivitiesView.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 09/06/2023.
//

import SwiftUI

struct DayActivitiesView: View {
    @State private var selectedTable: DayActivity.ID?

    var body: some View {
        VStack {
            Table(PreviewMockedData.activities, selection: $selectedTable) {
                TableColumn("Date", value: \.dateString)
                    .width(min: 45, ideal: 100)
                TableColumn("Zaishen Mission", value: \.zaishen_mission_title)
                    .width(min: 90, ideal: 100)
                TableColumn("Zaishen Bounty", value: \.zaishen_bounty_title)
                    .width(min: 90, ideal: 100)
                TableColumn("Zaishen Combat", value: \.zaishen_combat_title)
                    .width(min: 90, ideal: 100)
                TableColumn("Zaishen Vanquish", value: \.zaishen_vanquish_title)
                    .width(min: 90, ideal: 100)
                TableColumn("Shining Blade", value: \.shining_blade_title)
                    .width(min: 90, ideal: 100)
                TableColumn("Vanguard Quest", value: \.vanguard_quest_title)
                    .width(min: 90, ideal: 100)
                TableColumn("Nicholas Sandford", value: \.nicholas_sandford_title)
                    .width(min: 90, ideal: 100)
            }
            .frame(minWidth: 550, maxHeight: .infinity)
        }
    }
}

struct DayActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        DayActivitiesView()
    }
}
