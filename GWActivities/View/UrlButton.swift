//
//  UrlButton.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 05/12/2023.
//

import SwiftUI

struct UrlButton: View {
    var title: String
    var url: URL?
    var body: some View {
        if let url {
            Link(title, destination: url)
                .padding(.horizontal, 5)
                .lineLimit(1)
                .font(.subheadline)
                .buttonStyle(.plain)
                .foregroundColor(.brandPrimary)
                .background {
                    Capsule()
                        .foregroundStyle(.secondary)
                        .opacity(0.1)
                }
        } else {
            Text(title)
                .padding(.horizontal, 5)
                .lineLimit(1)
                .font(.subheadline)
                .buttonStyle(.plain)
                .background {
                    Capsule()
                        .foregroundStyle(.secondary)
                        .opacity(0.1)
                }

        }
    }
}

#Preview {
    UrlButton(title: "Spider Legs", url: URL(string: "https://www.apple.com"))
}
