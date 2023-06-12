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

    var body: some View {
        VStack {
            Table(content, selection: $selectedLine) {
                TableColumn("Week Starting", value: \.week_startingString)
                    .width(min: 45, ideal: 100)
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
            .frame(minWidth: 550, maxHeight: .infinity)
            Text("\(content.count) week activities activities found")
                .font(.subheadline)
                .padding(.bottom, 5)
        }
    }
}

struct WeekActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        WeekActivitiesView(selectedLine: .constant(nil), content: .constant(PreviewMockedData.weekActivities))
    }
}
