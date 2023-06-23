//
//  TodayTextView.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 23/06/2023.
//

import SwiftUI

struct TodayTextView: View {
    let dayActivity: DayActivity

    var body: some View {
        VStack(alignment: .leading) {
            Text("Today:")
                .foregroundColor(Color("color2"))
                .font(.title2)
                .bold()
            Group {
                HStack(spacing: 3) {
                    Text("Nicholas Sandford:")
                        .bold()
                    Text(dayActivity.nicholas_sandford.title)
                }
                HStack(spacing: 3) {
                    Text("Vanguard quest:")
                        .bold()
                    Text(dayActivity.vanguard_quest.title)
                }
                HStack(spacing: 3) {
                    Text("Wanted:")
                        .bold()
                    Text(dayActivity.shining_blade.title)
                }
                HStack(spacing: 3) {
                    Text("Zaishen Mission:")
                        .bold()
                    Text(dayActivity.zaishen_mission.title)
                }
                HStack(spacing: 3) {
                    Text("Zaishen Bounty:")
                        .bold()
                    Text(dayActivity.zaishen_bounty.title)
                }
                HStack(spacing: 3) {
                    Text("Zaishen Combat:")
                        .bold()
                    Text(dayActivity.zaishen_combat.title)
                }
                HStack(spacing: 3) {
                    Text("Zaishen Vanquish:")
                        .bold()
                    Text(dayActivity.zaishen_vanquish.title)
                }
            }
            .font(.body)
            .padding(.leading, 7)
            .lineLimit(1)
            .foregroundColor(Color("color1"))
        }
    }
}

struct TodayTextView_Previews: PreviewProvider {
    static var previews: some View {
        TodayTextView(dayActivity: PreviewMockedData.activities.first!)
    }
}
