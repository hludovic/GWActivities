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
                    Text("Nicholas Sandford: Worn Belts")
                    Text("Vanguard quest: Ascalonian Noble")
                    Text("Wanted: Calamitous")
                    Text("Zaishen Mission: Abaddon's Mouth")
                    Text("Zaishen Bounty: Remnant of Antiquities")
                    Text("Zaishen Combat: Guild Versus Guild")
                    Text("Zaishen Vanquish: Issnur Isles")
                }
                .padding(.leading, 7)
                .lineLimit(1)
                .font(.title3)
                Text("This week:")
                    .font(.title2)
                    .bold()
                Group {
                    Text("Nicholas the Traveler: 1 Gold Doubloon in Barbarous Shore")
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
