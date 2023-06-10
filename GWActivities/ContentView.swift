//
//  ContentView.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 09/06/2023.
//

import SwiftUI

struct ContentView: View {
    @State var stuff: [DayActivity]?
    @State var select: DayActivity.ID?
    @State var searchable: String = ""
    var colors = ["Daily activities", "Weekly activities", "Monthly activities", "Events"]
    @State private var selectedColor = "Daily activities"

    var body: some View {
        DayActivitiesView(selectedTable: $select, content: $stuff)
            .navigationTitle(Text("Guild Wars activities"))
            .onChange(of: stuff) { newValue in
                guard let stuff = stuff else { return }
                for ffuts in stuff {
                    if ffuts.isSameDayThan(date: Date()) {
                        select = ffuts.id
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button {
                        Task {
                            do {
                                stuff = try await Scraper.maintStuff()
                            }
                        }
                    } label: {
                        Label("Refresh", systemImage: "arrow.triangle.2.circlepath")
                    }
                }
                ToolbarItem {
                    Picker("Picker", selection: $selectedColor) {
                        ForEach(colors, id: \.self) { item in
                            Text(item)
                        }
                    }
                }
            }
            .searchable(text: $searchable)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
