//
//  DayActivity.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 09/06/2023.
//

import Foundation

struct DayActivity: Identifiable, Codable, Equatable {
    static func == (lhs: DayActivity, rhs: DayActivity) -> Bool {
        return lhs.id == rhs.id
    }
    let id: UUID
    let date: Date
    struct Nicholas_Sandford: Codable {
        let title: String
        let url: URL
    }
    let nicholas_sandford: Nicholas_Sandford
    struct Vanguard_Quest: Codable {
        let title: String
        let url: URL
    }
    let vanguard_quest: Vanguard_Quest
    struct Shining_Blade: Codable {
        let title: String
        let url: URL
    }
    let shining_blade: Shining_Blade
    struct Zaishen_Mission: Codable {
        let title: String
        let url: URL
    }
    let zaishen_mission: Zaishen_Mission
    struct Zaishen_Bounty: Codable {
        let title: String
        let url: URL
    }
    let zaishen_bounty: Zaishen_Bounty
    struct Zaishen_Combat: Codable {
        let title: String
        let url: URL
    }
    let zaishen_combat: Zaishen_Combat
    struct Zaishen_Vanquish: Codable {
        let title: String
        let url: URL
    }
    let zaishen_vanquish: Zaishen_Vanquish
}
