//
//  WeekActivitiesView.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 11/06/2023.
//

import SwiftUI

struct WeekActivitiesView: View {
    @Binding var selectedLine: DayActivity.ID?
    @Binding var content: [WeekActivity]
    @Binding var currentWeekLineID: WeekActivity.ID?
    @State private var sortOrder = [KeyPathComparator(\WeekActivity.week_starting)]

    var body: some View {
        if content.isEmpty {
            NoContentView(activity: .weekly)
        } else {
            VStack {
                Table(content, selection: $selectedLine, sortOrder: $sortOrder) {
                    TableColumn("Week Starting", sortUsing: KeyPathComparator(\WeekActivity.week_starting)) { line in
                        line.id == currentWeekLineID ? Text(line.week_startingString).fontWeight(.semibold) : Text(line.week_startingString)
                    }.width(min: 90, ideal: 100)
                    TableColumn("PvE Bonus", value: \.pve_bonus.title)
                        .width(min: 45, ideal: 100)
                    TableColumn("PvP Bonus", value: \.pvp_bonus.title)
                        .width(min: 45, ideal: 100)
                    TableColumn("Nicholas Item", value: \.nicholas_item.title)
                        .width(min: 45, ideal: 100)
                    TableColumn("Nicholas Location", value: \.nicholas_location.title)
                        .width(min: 45, ideal: 100)
                    TableColumn("Nicholas Map", value: \.nicholas_map.title)
                        .width(min: 45, ideal: 100)
                }
                .onChange(of: sortOrder) { newOrder in
                    content.sort(using: sortOrder)
                }
                .frame(minWidth: 550, maxHeight: .infinity)
                Text("\(content.count) week activities activities found")
                    .font(.subheadline)
                    .padding(.bottom, 5)
            }
        }
    }
}

struct WeekActivitiesView_Previews: PreviewProvider {
    static let currentWeekLineID = WeekActivity.fakeData[0].id
    static var previews: some View {
        WeekActivitiesView(
            selectedLine: .constant(nil),
            content: .constant(WeekActivity.fakeData), currentWeekLineID: .constant(currentWeekLineID)
        )
    }
}
