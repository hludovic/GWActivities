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
                Task { await viewModel.pressRefreshButton() }
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
                viewModel.pressExportButton()
            } label: {
                Label("Export", systemImage: "arrow.up.doc")
            }
            .disabled(viewModel.isExportdisabled)
            .fileExporter( isPresented: $viewModel.isExporting, document: viewModel.document, contentType: .commaSeparatedText, defaultFilename: "Message.csv" ) { result in
                switch result {
                case .success(let url):
                    print("Saved to \(url)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
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
