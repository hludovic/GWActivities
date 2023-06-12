//
//  DayActivitiesView.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 09/06/2023.
//

import SwiftUI

struct DayActivitiesView: View {
    @Binding var selectedLine: DayActivity.ID?
    @Binding var content: [DayActivity]
    @Binding var isLoading: Bool

    var body: some View {
        if isLoading {
            ProgressView("Loading...")
        } else if content.count == 0 {
            VStack {
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .foregroundColor(.yellow)
                Text("Day Activity")
                Text("No content loaded")
                    .font(.title2)
                Text("Please refresh")
            }
        } else {
            VStack {
                Table(content, selection: $selectedLine) {
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
                Text("\(content.count) daily activities found")
                    .font(.subheadline)
                    .padding(.bottom, 5)
            }
        }
    }
}

struct DayActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        DayActivitiesView(
            selectedLine: .constant(nil),
            content: .constant(PreviewMockedData.activities),
            isLoading: .constant(false)
        )
    }
}
