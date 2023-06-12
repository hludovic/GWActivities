//
//  WeekActivity.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 11/06/2023.
//

import Foundation

struct WeekActivity: Identifiable, Codable, Equatable {
    static func == (lhs: WeekActivity, rhs: WeekActivity) -> Bool {
        return lhs.id == rhs.id
    }
    let id: UUID
    let week_starting: Date
    var week_startingString: String {
        return week_starting.formatted(date: .long, time: .omitted)
    }
    struct PvE_Bonus: Codable {
        let title: String
        let url: URL
    }
    let pve_bonus: PvE_Bonus

    struct PvP_Bonus: Codable {
        let title: String
        let url: URL
    }
    let pvp_bonus: PvP_Bonus
    struct Nicholas_Item: Codable {
        let title: String
        let url: URL
    }
    let nicholas_item: Nicholas_Item
    struct Nicholas_Location: Codable {
        let title: String
        let url: URL
    }
    let nicholas_location: Nicholas_Location
    struct Nicholas_Map: Codable {
        let title: String
        let url: URL
    }
    let nicholas_map: Nicholas_Map

    func isSameDayThan(date: Date) -> Bool {
        let today = Date().formatted(date: .long, time: .omitted)
        return today == week_startingString
    }
}
