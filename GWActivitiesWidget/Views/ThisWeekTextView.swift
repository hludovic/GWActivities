//
//  ThisWeekTextView.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 23/06/2023.
//

import SwiftUI

struct ThisWeekTextView: View {
    let weekActivity: WeekActivity

    var body: some View {
        VStack(alignment: .leading) {
            Text("This week:")
                .foregroundColor(Color("color2"))
                .font(.title2)
                .bold()
            Group {
                HStack(spacing: 3) {
                    Text("Nicholas the Traveler request:")
                        .bold()
                    Text(weekActivity.nicholas_item.title)
                }
                HStack(spacing: 3) {
                    Text("Nicholas the Traveler location:")
                        .bold()
                    Text(weekActivity.nicholas_location.title)
                }
                HStack(spacing: 3) {
                    Text("Weekly PvE bonus:")
                        .bold()
                    Text(weekActivity.pve_bonus.title)
                }
                HStack(spacing: 3) {
                    Text("Weekly PvP bonus:")
                        .bold()
                    Text(weekActivity.pvp_bonus.title)
                }
            }
            .font(.body)
            .padding(.leading, 7)
            .lineLimit(1)
            .foregroundColor(Color("color1"))
        }
    }
}

struct ThisWeekTextView_Previews: PreviewProvider {
    static var previews: some View {
        ThisWeekTextView(weekActivity: PreviewMockedData.weekActivities.first!)
    }
}
