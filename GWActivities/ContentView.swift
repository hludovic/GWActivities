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
    var body: some View {
        DayActivitiesView(selectedTable: $select, content: $stuff)
            .onChange(of: stuff) { newValue in
                guard let stuff = stuff else { return }
                for ffuts in stuff {
                    if ffuts.isSameDayThan(date: Date()) {
                        select = ffuts.id
                    }
                }

            }
            .toolbar {
                ToolbarItem {
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
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
