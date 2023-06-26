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
    @Binding var currentDayLineID: DayActivity.ID?
    @State private var sortOrder = [KeyPathComparator(\DayActivity.date)]

    var body: some View {
        if content.isEmpty {
            NoContentView(activity: .daily)
        } else {
            VStack {
                Table(content, selection: $selectedLine, sortOrder: $sortOrder) {
                    TableColumn("Date", sortUsing: KeyPathComparator(\DayActivity.date)) { line in
                        line.id == currentDayLineID
                        ? Text(line.date.toString).foregroundColor(.brown).fontWeight(.semibold)
                        : Text(line.date.toString)
                    }.width(min: 90, ideal: 100)
                    TableColumn("Zaishen Mission", sortUsing: KeyPathComparator(\DayActivity.zaishen_mission.title)) { line in
                        line.id == currentDayLineID
                        ? Text(line.zaishen_mission.title).foregroundColor(.brown).fontWeight(.semibold)
                        : Text(line.zaishen_mission.title)
                    }.width(min: 90, ideal: 100)
                    TableColumn("Zaishen Bounty", sortUsing: KeyPathComparator(\DayActivity.zaishen_bounty.title)) { line in
                        line.id == currentDayLineID
                        ? Text(line.zaishen_bounty.title).foregroundColor(.brown).fontWeight(.semibold)
                        : Text(line.zaishen_bounty.title)
                    }.width(min: 90, ideal: 100)
                    TableColumn("Zaishen Combat", sortUsing: KeyPathComparator(\DayActivity.zaishen_combat.title)) { line in
                        line.id == currentDayLineID
                        ? Text(line.zaishen_combat.title).foregroundColor(.brown).fontWeight(.semibold)
                        : Text(line.zaishen_combat.title)
                    }.width(min: 90, ideal: 100)
                    TableColumn("Zaishen Vanquish", sortUsing: KeyPathComparator(\DayActivity.zaishen_vanquish.title)) { line in
                        line.id == currentDayLineID
                        ? Text(line.zaishen_vanquish.title).foregroundColor(.brown).fontWeight(.semibold)
                        : Text(line.zaishen_vanquish.title)
                    }.width(min: 90, ideal: 100)
                    TableColumn("Shining Blade", sortUsing: KeyPathComparator(\DayActivity.shining_blade.title)) { line in
                        line.id == currentDayLineID
                        ? Text(line.shining_blade.title).foregroundColor(.brown).fontWeight(.semibold)
                        : Text(line.shining_blade.title)
                    }.width(min: 90, ideal: 100)
                    TableColumn("Vanguard Quest", sortUsing: KeyPathComparator(\DayActivity.vanguard_quest.title)) { line in
                        line.id == currentDayLineID
                        ? Text(line.vanguard_quest.title).foregroundColor(.brown).fontWeight(.semibold)
                        : Text(line.vanguard_quest.title)
                    }.width(min: 90, ideal: 100)
                    TableColumn("Nicholas Sandford", sortUsing: KeyPathComparator(\DayActivity.nicholas_sandford.title)) { line in
                        line.id == currentDayLineID
                        ? Text(line.nicholas_sandford.title).foregroundColor(.brown).fontWeight(.semibold)
                        : Text(line.nicholas_sandford.title)
                    }.width(min: 90, ideal: 100)
                }
                .onChange(of: sortOrder) { newOrder in
                    content.sort(using: sortOrder)
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
    static let currentDayLineID = DayActivity.fakeData[1].id
    static var previews: some View {
        DayActivitiesView(
            selectedLine: .constant(nil),
            content: .constant(DayActivity.fakeData), currentDayLineID: .constant(currentDayLineID)
        )
    }
}
