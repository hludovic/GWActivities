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
                    if viewModel.selectedActivity == .daily {
                        await viewModel.downloadDailyActivities()
                    } else if viewModel.selectedActivity == .weekly {
                        await viewModel.downloadWeeklyActivities()
                    }
                }
            } label: {
                Label("Refresh", systemImage: "arrow.triangle.2.circlepath")
            }
            .disabled(viewModel.isLoading)
        }
        ToolbarItem {
            Picker("Picker", selection: $viewModel.selectedActivity) {
                ForEach(Activity.allCases) { activity in
                    Text(activity.name).tag(activity)
                }
            }
        }
        ToolbarItem {
            Button {
                print("todo")
            } label: {
                Label("Export", systemImage: "square.and.arrow.up")
            }
        }
        ToolbarItem {
            Button {
                print("todo")
            } label: {
                Label("Inspector", systemImage: "info")
            }
        }
    }
}
