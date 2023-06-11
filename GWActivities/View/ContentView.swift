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
            DayActivitiesView(selectedTable: $viewModel.lineSelected, content: $viewModel.dayActivities)
            Text("\(viewModel.dayActivities.count) activities found")
                .font(.subheadline)
                .padding(.bottom, 5)
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.displayAlert) {
            Button("OK", role: .cancel) { }
        }
        .navigationTitle(Text("Guild Wars activities"))
        .searchable(text: $viewModel.searchable)
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
