//
//  InspectorWeekView.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 06/11/2023.
//

import SwiftUI

struct InspectorWeekView: View {
    @Binding var content: WeekActivity?

    var body: some View {
        ScrollView(.vertical) {
            Text("Activity Helper")
                .padding(.top)
                .font(.title3)
            Text(content?.week_starting.toString ?? "-")
                .font(.caption)
                .foregroundStyle(.secondary)
            Divider()
            HStack {
                Text("Nicholas the Traveler:")
                    .lineLimit(1)
                    .padding(.leading, 7)
                    .font(.title3)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.top, 10)
            .padding(.bottom, 5)
            HStack {
                VStack {
                    HStack{
                        Text("Nicholas location:")
                            .lineLimit(1)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(.bottom, 1)
                    .padding(.leading, 7)
                    HStack{
                        Text("Nicholas item:")
                            .lineLimit(1)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(.bottom, 1)
                    .padding(.leading, 7)
                    HStack{
                        Text("Nicholas map:")
                            .lineLimit(1)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(.bottom, 1)
                    .padding(.leading, 7)
                }
                VStack {
                    HStack{
                        UrlButton(
                            title: content?.nicholas_location.title ?? "-",
                            url: content?.nicholas_location.url)
                            .padding(.bottom, 1)
                            .offset(x: -10)
                        Spacer()
                    }
                    HStack{
                        UrlButton(
                            title: content?.nicholas_item.title ?? "-",
                            url: content?.nicholas_location.url)
                            .padding(.bottom, 1)
                            .offset(x: -10)
                        Spacer()
                    }
                    HStack{
                        UrlButton(
                            title: content?.nicholas_map.title ?? "-",
                            url: content?.nicholas_map.url)
                            .padding(.bottom, 1)
                            .offset(x: -10)
                        Spacer()
                    }
                }
            }
            HStack {
                Text("Weekly bonuses:")
                    .lineLimit(1)
                    .padding(.leading, 7)
                    .font(.title3)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.vertical, 5)
            HStack {
                VStack {
                    HStack{
                        Text("PvE bonus:")
                            .lineLimit(1)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(.bottom, 1)
                    .padding(.leading, 7)
                    HStack{
                        Text("PvP bonus:")
                            .lineLimit(1)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(.bottom, 1)
                    .padding(.leading, 7)
                }
                VStack {
                    HStack{
                        UrlButton(
                            title: content?.pve_bonus.title ?? "-",
                            url: content?.pve_bonus.url)
                            .padding(.bottom, 1)
                            .offset(x: -10)
                        Spacer()
                    }
                    HStack{
                        UrlButton(
                            title: content?.pvp_bonus.title ?? "-",
                            url: content?.pvp_bonus.url)
                            .padding(.bottom, 1)
                            .offset(x: -10)
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    InspectorWeekView(content: .constant(WeekActivity.fakeData[0]))
}
