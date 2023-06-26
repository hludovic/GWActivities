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
}

extension WeekActivity {

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
        let weekActivity2 = WeekActivity(
            id: UUID(),
            week_starting: .now,
            pve_bonus: WeekActivity.PvE_Bonus(
                title: "Zaishen Mission", url: URL(string: "/wiki/Zaishen_Mission")!),
            pvp_bonus: WeekActivity.PvP_Bonus(
                title: "Alliance Battle", url: URL(string: "/wiki/Alliance_Battles")!),
            nicholas_item: WeekActivity.Nicholas_Item(
                title: "Gold Doubloon (1x)", url: URL(string: "/wiki/Gold_Doubloon")!),
            nicholas_location: WeekActivity.Nicholas_Location(
                title: "Barbarous Shore", url: URL(string: "/wiki/Barbarous_Shore")!),
            nicholas_map: WeekActivity.Nicholas_Map(
                title: "Map", url: URL(string: "/wiki/File:Nicholas_the_Traveler_Barbarous_Shore_map.jpg")!)
        )

        let weekActivity3 = WeekActivity(
            id: UUID(),
            week_starting: Date.dateCreator(year: 2023, month: 5, day: 29),
            pve_bonus: WeekActivity.PvE_Bonus(
                title: "Pantheon", url: URL(string: "/wiki/")!),
            pvp_bonus: WeekActivity.PvP_Bonus(
                title: "Random Arenas", url: URL(string: "/wiki/Random_Arenas")!),
            nicholas_item: WeekActivity.Nicholas_Item(
                title: "Shriveled Eyes (2x)", url: URL(string: "/wiki/Shriveled_Eye")!),
            nicholas_location: WeekActivity.Nicholas_Location(
                title: "Skyward Reach", url: URL(string: "/wiki/Skyward_Reach")!),
            nicholas_map: WeekActivity.Nicholas_Map(
                title: "Map", url: URL(string: "/wiki/File:Nicholas_the_Traveler_Skyward_Reach_map.jpg")!)
        )
        return[weekActivity1, weekActivity2, weekActivity3]
    }
}
