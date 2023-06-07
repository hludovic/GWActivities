//
//  Activity.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 06/06/2023.
//

import Foundation

struct DayActivity: Identifiable {
    let id: UUID = UUID()
    let date: Date
    var dateString: String {
        return date.formatted(date: .long, time: .omitted)
    }
    let nicholas_sandford_title: String
    let nicholas_sandford_url: URL
    let vanguard_quest_title: String
    let vanguard_quest_url: URL
    let shining_blade_title: String
    let shining_blade_url: URL
    let zaishen_mission_title: String
    let zaishen_mission_url: URL
    let zaishen_bounty_title: String
    let zaishen_bounty_url: URL
    let zaishen_combat_title: String
    let zaishen_combat_url: URL
    let zaishen_vanquish_title: String
    let zaishen_vanquish_url: URL
}
