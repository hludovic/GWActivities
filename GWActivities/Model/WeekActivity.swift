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

    func isEqual(to date: Date, toGranularity component: Calendar.Component) -> Bool {
        Calendar.current.isDate(week_starting, equalTo: date, toGranularity: component)
    }
}

extension WeekActivity {

    static var placeholder: WeekActivity {
        return WeekActivity(
            id: UUID(),
            week_starting: Date(),
            pve_bonus: WeekActivity.PvE_Bonus(
                title: " ", url: URL(string: "/wiki/")!),
            pvp_bonus: WeekActivity.PvP_Bonus(
                title: " ", url: URL(string: "/wiki/")!),
            nicholas_item: WeekActivity.Nicholas_Item(
                title: " ", url: URL(string: "/wiki/")!),
            nicholas_location: WeekActivity.Nicholas_Location(
                title: " ", url: URL(string: "/wiki/")!),
            nicholas_map: WeekActivity.Nicholas_Map(
                title: " ", url: URL(string: "/wiki/")!)
        )

    }

    static var fakeData: [WeekActivity] {
        let weekActivity1 = WeekActivity(
            id: UUID(),
            week_starting: Date.dateCreator(year: 2023, month: 5, day: 29),
            pve_bonus: WeekActivity.PvE_Bonus(
                title: "Zaishen Bounty", url: URL(string: "/wiki/Zaishen_Bounty")!),
            pvp_bonus: WeekActivity.PvP_Bonus(
                title: "Competitive Mission", url: URL(string: "/wiki/Competitive_Mission")!),
            nicholas_item: WeekActivity.Nicholas_Item(
                title: "Luminous Stone (1x)", url: URL(string: "/wiki/Luminous_Stone")!),
            nicholas_location: WeekActivity.Nicholas_Location(
                title: "Crystal Overlook", url: URL(string: "/wiki/Crystal_Overlook")!),
            nicholas_map: WeekActivity.Nicholas_Map(
                title: "Map", url: URL(string: "/wiki/File:Nicholas_the_Traveler_Crystal_Overlook_map.jpg")!)
        )
        return[weekActivity1]
    }
}
