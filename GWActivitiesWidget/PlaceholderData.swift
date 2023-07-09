//
//  PlaceholderData.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 09/07/2023.
//

import Foundation

extension DayActivity {

    static var placeholder: DayActivity {
       return DayActivity(
            id: UUID(),
            date: Date(),
            nicholas_sandford: DayActivity.Nicholas_Sandford(
                title: "Unnatural Seeds", url: URL(string: "/wiki/Unnatural_Seed")!),
            vanguard_quest: DayActivity.Vanguard_Quest(
                title: "Utini Wupwup", url: URL(string: "/wiki/Vanguard_Bounty:_Utini_Wupwup")!),
            shining_blade: DayActivity.Shining_Blade(
                title: "Lev the Condemned", url: URL(string: "/wiki/Wanted:_Lev_the_Condemned")!),
            zaishen_mission: DayActivity.Zaishen_Mission(
                title: "Ruins of Surmia", url: URL(string: "/wiki/Ruins_of_Surmia_(Zaishen_quest)")!),
            zaishen_bounty: DayActivity.Zaishen_Bounty(
                title: "Borrguus Blisterbark", url: URL(string: "/wiki/Borrguus_Blisterbark_(Zaishen_quest)")!),
            zaishen_combat: DayActivity.Zaishen_Combat(
                title: "Heroes' Ascent", url: URL(string: "/wiki/Heroes%27_Ascent_(Zaishen_quest)")!),
            zaishen_vanquish: DayActivity.Zaishen_Vanquish(
                title: "Forum Highlands", url: URL(string: "/wiki/Forum_Highlands_(Zaishen_vanquish)")!)
        )
    }
}

extension WeekActivity {

    static var placeholder: WeekActivity {
        return WeekActivity(
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
    }
}
