//
//  ToolbarItems.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 10/06/2023.
//

import SwiftUI

struct ToolbarItems: ToolbarContent {
    @ObservedObject var viewModel: ContentViewModel

    var body: some ToolbarContent {
        ToolbarItem(placement: .navigation) {
            Button {
                Task {
                    await viewModel.downloadDailyActivities()
                }
            } label: {
                Label("Refresh", systemImage: "arrow.triangle.2.circlepath")
            }
        }
        ToolbarItem {
            Picker("Picker", selection: $viewModel.selectedActivity) {
                ForEach(Activity.allCases) { activity in
                    Text(activity.name).tag(activity)
                }
            }
        }
    }
}
