//
//  Activity.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 10/06/2023.
//

import Foundation

enum Activity: Int, CaseIterable, Identifiable {
    case daily, weekly, monthly, events

    var id: Int { self.rawValue }

    var name: String {
        switch self {
        case .daily: return "Daily activities"
        case .weekly: return "Weekly activities"
        case .monthly: return "Monthly activities"
        case .events: return "Events"
        }
    }

    var url: URL? {
        switch self {
        case .daily:
            return URL(string: "https://wiki.guildwars.com/wiki/Daily_activities")!
        case .weekly:
            return URL(string: "https://wiki.guildwars.com/wiki/Weekly_activities")!
        case .monthly:
            return nil
        case .events:
            return nil
        }
    }
}
