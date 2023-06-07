//
//  ActivitiesView.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 06/06/2023.
//

import SwiftUI

struct ActivitiesView: View {
    @State private var selectedTable: DayActivity.ID?
    @State private var activity: DayActivity?

    var body: some View {

        VStack {
            HSplitView {
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
                if activity != nil {
                    ActivityDescription(dayActivity: $activity)
                        .frame(minWidth: 250, maxHeight: .infinity)
                }
            }
            .onChange(of: selectedTable) { newValue in
                if let newValue {
                    activity = PreviewMockedData.getActivity(id: newValue)
                }
            }
            if let selectedTable {
                Text("\(selectedTable.uuidString) people selected")
            } else { Text(" ") }

        }
        .toolbar {
            ToolbarItemGroup {
                Button {
                    print("Hello")
                } label: {
                    Label("Label", systemImage: "icloud.and.arrow.down.fill")
                }
                Button {
                    print("Hello")
                } label: {
                    Label("Label", systemImage: "sidebar.right")
                }
            }
        }
    }

}

struct ActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView()
    }
}
