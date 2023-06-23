//
//  WidgetView.swift
//  GWActivitiesWidgetExtension
//
//  Created by Ludovic HENRY on 21/06/2023.
//

import WidgetKit
import SwiftUI

struct WidgetView: View {
    var entry: SimpleEntry
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        ZStack {
            Image("gwIcon")
                .resizable()
                .opacity(0.12)
                .blur(radius: 2)
            ContainerRelativeShape()
                .fill(.orange.gradient)
                .opacity(0.3)
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text("Latest in-game activities")
                        .font(.title.bold())
                        .foregroundColor(Color("brown_massif"))
                        .padding(.vertical, 5)
                    Spacer()
                }
                Text("Today:")
                    .font(.title2)
                    .bold()
                Group{
                    Text("Nicholas Sandford: \(entry.lastestActivities.dayActivity.nicholas_sandford.title)")
                    Text("Vanguard quest: \(entry.lastestActivities.dayActivity.vanguard_quest.title)")
                    Text("Wanted: \(entry.lastestActivities.dayActivity.shining_blade.title)")
                    Text("Zaishen Mission: \(entry.lastestActivities.dayActivity.zaishen_mission.title)")
                    Text("Zaishen Bounty: \(entry.lastestActivities.dayActivity.zaishen_bounty.title)")
                    Text("Zaishen Combat: \(entry.lastestActivities.dayActivity.zaishen_combat.title)")
                    Text("Zaishen Vanquish: \(entry.lastestActivities.dayActivity.zaishen_vanquish.title)")
                }
                .padding(.leading, 7)
                .lineLimit(1)
                .font(.title3)
                Text("This week:")
                    .font(.title2)
                    .bold()
                Group {
                    Text("Nicholas the Traveler: \(entry.lastestActivities.weekActivity.nicholas_item.title) in \(entry.lastestActivities.weekActivity.nicholas_location.title)")
                    Text("Weekly bonuses: Zaishen Mission Bonus; Alliance Battle Bonus")
                    Text("Today: \(entry.date.formatted(date: .abbreviated, time: .omitted))")
                }
                .padding(.leading, 7)
                .lineLimit(1)
                .font(.title3)
                Text("This month:")
                    .font(.title2)
                    .bold()
                Group {
                    Text("Flux: Jack of All Trades")
                }
                .padding(.leading, 7)
                .lineLimit(1)
                .font(.title3)
                Spacer()
            }
            .padding()
        }
    }
}
