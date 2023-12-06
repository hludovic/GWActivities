//
//  ContentView.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 09/06/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel = ContentViewModel()

    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                LoadingView()
            } else {
                switch viewModel.selectedActivity {
                case .daily:
                    DayActivitiesView(
                        selectedLine: $viewModel.lineSelected,
                        content: $viewModel.dayActivities,
                        currentDayLineID: $viewModel.currentDayLineID
                    )
                    .inspector(isPresented: $viewModel.isShowingInspector) {
                        InspectorDayView(content: $viewModel.currentDayActivitySelected)
                            .inspectorColumnWidth(min: 250, ideal: 300, max: 400)
                    }
                case .weekly:
                    WeekActivitiesView(
                        selectedLine: $viewModel.lineSelected,
                        content: $viewModel.weekActivities,
                        currentWeekLineID: $viewModel.currentWeekLineID
                    )
                    .inspector(isPresented: $viewModel.isShowingInspector) {
                        InspectorWeekView(content: $viewModel.currentWeekActivitySelected)
                            .inspectorColumnWidth(min: 250, ideal: 250, max: 300)
                    }
                case .monthly:
                    Text("Not Implemented")
                case .events:
                    Text("Not Implemented")
                }
            }
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.displayAlert) {
            Button("OK", role: .cancel) { }
        }
        .navigationTitle(Text("Guild Wars activities"))
        .toolbar {
            ToolbarItems(viewModel: viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
