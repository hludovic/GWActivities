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
                        line.id == currentWeekLineID
                        ? Text(line.week_starting.toString).foregroundColor(.brown).fontWeight(.semibold)
                        : Text(line.week_starting.toString)
                    }.width(min: 90, ideal: 100)
                    TableColumn("PvE Bonus", sortUsing: KeyPathComparator(\WeekActivity.pve_bonus.title)) { line in
                        line.id == currentWeekLineID
                        ? Text(line.pve_bonus.title).foregroundColor(.brown).fontWeight(.semibold)
                        : Text(line.pve_bonus.title)
                    }.width(min: 90, ideal: 100)
                    TableColumn("PvP Bonus", sortUsing: KeyPathComparator(\WeekActivity.pvp_bonus.title)) { line in
                        line.id == currentWeekLineID
                        ? Text(line.pvp_bonus.title).foregroundColor(.brown).fontWeight(.semibold)
                        : Text(line.pvp_bonus.title)
                    }.width(min: 90, ideal: 100)
                    TableColumn("Nicholas Item", sortUsing: KeyPathComparator(\WeekActivity.nicholas_item.title)) { line in
                        line.id == currentWeekLineID 
                        ? Text(line.nicholas_item.title).foregroundColor(.brown).fontWeight(.semibold)
                        : Text(line.nicholas_item.title)
                    }.width(min: 90, ideal: 100)
                    TableColumn("Nicholas Location", sortUsing: KeyPathComparator(\WeekActivity.nicholas_location.title)) { line in
                        line.id == currentWeekLineID
                        ? Text(line.nicholas_location.title).foregroundColor(.brown).fontWeight(.semibold)
                        : Text(line.nicholas_location.title)
                    }.width(min: 90, ideal: 100)
                    TableColumn("Nicholas Map", sortUsing: KeyPathComparator(\WeekActivity.nicholas_map.title)) { line in
                        line.id == currentWeekLineID
                        ? Text(line.nicholas_map.title).foregroundColor(.brown).fontWeight(.semibold)
                        : Text(line.nicholas_map.title)
                    }.width(min: 90, ideal: 100)
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
