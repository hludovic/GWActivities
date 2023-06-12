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
        VStack {
            switch viewModel.selectedActivity {
            case .daily:
                DayActivitiesView(
                    selectedLine: $viewModel.lineSelected,
                    content: $viewModel.dayActivities,
                    isLoading: $viewModel.isLoading
                )
            case .weekly:
                WeekActivitiesView(
                    selectedLine: $viewModel.lineSelected,
                    content: $viewModel.weekActivities,
                    isLoading: $viewModel.isLoading)
            case .monthly:
                Text("Not Implemented")
            case .events:
                Text("Not Implemented")
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
