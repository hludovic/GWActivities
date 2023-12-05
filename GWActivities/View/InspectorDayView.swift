//
//  InspectorDayView.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 06/11/2023.
//

import SwiftUI

struct InspectorDayView: View {
    @Binding var content: DayActivity?

    var body: some View {
        ScrollView(.vertical) {
            Text("Activity Helper")
                .padding(.top)
                .font(.title3)
            Text(content?.date.toString ?? "-")
                .font(.caption)
                .foregroundStyle(.secondary)
            Divider()
            HStack {
                VStack {
                    HStack{
                        Text("Nicholas Sandford:")
                            .lineLimit(1)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(.bottom, 1)
                    .padding(.leading, 7)
                    HStack{
                        Text("Vanguard quest:")
                            .lineLimit(1)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(.bottom, 1)
                    .padding(.leading, 7)
                    HStack{
                        Text("Wanted:")
                            .lineLimit(1)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(.bottom, 1)
                    .padding(.leading, 7)

                    HStack{
                        Text("Zaishen Mission:")
                            .lineLimit(1)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(.bottom, 1)
                    .padding(.leading, 7)
                    HStack{
                        Text("Zaishen Bounty:")
                            .lineLimit(1)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(.bottom, 1)
                    .padding(.leading, 7)
                    HStack{
                        Text("Zaishen Combat:")
                            .lineLimit(1)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(.bottom, 1)
                    .padding(.leading, 7)
                    HStack{
                        Text("Zaishen Vanquish:")
                            .lineLimit(1)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(.leading, 7)
                }
                VStack {
                    HStack{
                        UrlButton(
                            title: content?.nicholas_sandford.title ?? "-",
                            url: content?.nicholas_sandford.url)
                            .padding(.bottom, 1)
                            .offset(x: -10)
                        Spacer()
                    }
                    HStack{
                        UrlButton(
                            title: content?.vanguard_quest.title ?? "-",
                            url: content?.vanguard_quest.url)
                            .padding(.bottom, 1)
                            .offset(x: -10)
                        Spacer()
                    }
                    HStack{
                        UrlButton(
                            title: content?.shining_blade.title ?? "-",
                            url: content?.shining_blade.url)
                            .padding(.bottom, 1)
                            .offset(x: -10)
                        Spacer()
                    }
                    HStack{
                        UrlButton(
                            title: content?.zaishen_mission.title ?? "-",
                            url: content?.zaishen_mission.url)
                            .padding(.bottom, 1)
                            .offset(x: -10)
                        Spacer()
                    }
                    HStack{
                        UrlButton(
                            title: content?.zaishen_bounty.title ?? "-",
                            url: content?.zaishen_bounty.url)
                            .padding(.bottom, 1)
                            .offset(x: -10)
                        Spacer()
                    }
                    HStack{
                        UrlButton(
                            title: content?.zaishen_combat.title ?? "-",
                            url: content?.zaishen_combat.url)
                            .padding(.bottom, 1)
                            .offset(x: -10)
                        Spacer()
                    }
                    HStack{
                        UrlButton(
                            title: content?.zaishen_vanquish.title ?? "-",
                            url: content?.zaishen_vanquish.url)
                            .padding(.bottom, 1)
                            .offset(x: -10)
                        Spacer()
                    }
                }
            }
            .padding(.top, 10)
        }
    }
}

#Preview {
    InspectorDayView(content: .constant(DayActivity.fakeData[0]))
}
