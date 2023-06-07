//
//  ActivityDescription.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 06/06/2023.
//

import SwiftUI

struct ActivityDescription: View {
    @Binding var dayActivity: DayActivity?

    var body: some View {
        if let dayActivity {
            VStack(alignment: .leading, spacing: 10){
                Text("In-game activities for \(dayActivity.dateString)")
                    .font(.title2)
                HStack{
                    Text("Zaishen Mission:")
                    Link("\(dayActivity.zaishen_mission_title)",
                         destination: dayActivity.zaishen_mission_url)
                }
                HStack{
                    Text("Zaishen Bounty:")
                    Link("\(dayActivity.zaishen_bounty_title)",
                         destination: dayActivity.zaishen_bounty_url)
                }
                HStack{
                    Text("Zaishen Combat:")
                    Link("\(dayActivity.zaishen_combat_title)",
                         destination: dayActivity.zaishen_combat_url)
                }
                HStack{
                    Text("Zaishen Vanquish:")
                    Link("\(dayActivity.zaishen_vanquish_title)",
                         destination: dayActivity.zaishen_vanquish_url)
                }
                HStack{
                    Text("Shining Blade:")
                    Link("\(dayActivity.shining_blade_title)",
                         destination: dayActivity.shining_blade_url)
                }
                HStack{
                    Text("Vanguard Quest:")
                    Link("\(dayActivity.vanguard_quest_title)",
                         destination: dayActivity.vanguard_quest_url)
                }
                HStack{
                    Text("Nicholas Sandford:")
                    Link("\(dayActivity.nicholas_sandford_title)",
                         destination: dayActivity.nicholas_sandford_url)
                }
            }
            .padding()
        } else {
            Text("Rien")
        }
    }
}

struct ActivityDescription_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDescription(dayActivity: .constant(PreviewMockedData.activities[0]))
    }
}
