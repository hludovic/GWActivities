//
//  PreviewMockedData.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 09/06/2023.
//

import Foundation

struct PreviewMockedData {

    static let activities: [DayActivity] = [activity1, activity2, activity3]
    static let weekActivities: [WeekActivity] = [weekActivity1]

    private static let activity1 = DayActivity(
        id: UUID(),
        date: dateCreator(year: 2023, month: 6, day: 3),
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

    private static var activity2 = DayActivity(
        id: UUID(),
        date: dateCreator(year: 2023, month: 6, day: 4),
        nicholas_sandford: DayActivity.Nicholas_Sandford(
            title: "Red Iris Flowers", url: URL(string: "/wiki/Red_Iris_Flower")!),
        vanguard_quest: DayActivity.Vanguard_Quest(
            title: "Undead", url: URL(string: "/wiki/Vanguard_Annihilation:_Undead")!),
        shining_blade: DayActivity.Shining_Blade(
            title: "Justiciar Kasandra", url: URL(string: "/wiki/Wanted:_Justiciar_Kasandra")!),
        zaishen_mission: DayActivity.Zaishen_Mission(
            title: "Sunjiang District", url: URL(string: "/wiki/Sunjiang_District_(Zaishen_quest)")!),
        zaishen_bounty: DayActivity.Zaishen_Bounty(
            title: "Baubao Wavewrath", url: URL(string: "/wiki/Baubao_Wavewrath_(Zaishen_quest)")!),
        zaishen_combat: DayActivity.Zaishen_Combat(
            title: "Fort Aspenwood", url: URL(string: "/wiki/Fort_Aspenwood_(Zaishen_quest)")!),
        zaishen_vanquish: DayActivity.Zaishen_Vanquish(
            title: "Drakkar Lake", url: URL(string: "/wiki/Drakkar_Lake_(Zaishen_vanquish)")!)
    )

    private static var activity3 = DayActivity(
        id: UUID(),
        date: dateCreator(year: 2023, month: 6, day: 5),
        nicholas_sandford: DayActivity.Nicholas_Sandford(
            title: "Enchanted Lodestones", url: URL(string: "/wiki/Enchanted_Lodestone")!),
        vanguard_quest: DayActivity.Vanguard_Quest(
            title: "Blazefiend Griefblade", url: URL(string: "/wiki/Vanguard_Bounty:_Blazefiend_Griefblade")!),
        shining_blade: DayActivity.Shining_Blade(
            title: "Vess the Disputant", url: URL(string: "/wiki/Wanted:_Vess_the_Disputant")!),
        zaishen_mission: DayActivity.Zaishen_Mission(
            title: "Elona Reach", url: URL(string: "/wiki/Elona_Reach_(Zaishen_quest)")!),
        zaishen_bounty: DayActivity.Zaishen_Bounty(
            title: "Joffs the Mitigator", url: URL(string: "/wiki/Joffs_the_Mitigator_(Zaishen_quest)")!),
        zaishen_combat: DayActivity.Zaishen_Combat(
            title: "Jade Quarry", url: URL(string: "/wiki/Jade_Quarry_(Zaishen_quest)")!),
        zaishen_vanquish: DayActivity.Zaishen_Vanquish(
            title: "Dry Top", url: URL(string: "/wiki/Dry_Top_(Zaishen_vanquish)")!)
    )

    private static var weekActivity1 = WeekActivity(
        id: UUID(),
        week_starting: dateCreator(year: 2023, month: 5, day: 29),
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

    static func getActivity(id: DayActivity.ID) -> DayActivity? {
        guard let result = activities.first(where: { $0.id == id }) else { return nil }
        return result
    }

    static func dateCreator(year: Int, month: Int, day: Int) -> Date {
        var component: DateComponents = DateComponents()
        component.calendar = .current
        component.year = year
        component.month = month
        component.day = day
        return Calendar.current.date(from: component)!
    }
}
