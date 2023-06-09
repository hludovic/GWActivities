//
//  PreviewMockedData.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 09/06/2023.
//

import Foundation

struct PreviewMockedData {

    static let activities: [DayActivity] = [activity1, activity2, activity3]

    private static var activity1 = DayActivity(
        date: dateCreator(year: 2023, month: 6, day: 3),
        nicholas_sandford_title: "Unnatural Seeds",
        nicholas_sandford_url: URL(string: "/wiki/Unnatural_Seed")!,
        vanguard_quest_title: "Utini Wupwup",
        vanguard_quest_url: URL(string: "/wiki/Vanguard_Bounty:_Utini_Wupwup")!,
        shining_blade_title: "Lev the Condemned",
        shining_blade_url: URL(string: "/wiki/Wanted:_Lev_the_Condemned")!,
        zaishen_mission_title: "Ruins of Surmia",
        zaishen_mission_url: URL(string: "/wiki/Ruins_of_Surmia_(Zaishen_quest)")!,
        zaishen_bounty_title: "Borrguus Blisterbark",
        zaishen_bounty_url: URL(string: "/wiki/Borrguus_Blisterbark_(Zaishen_quest)")!,
        zaishen_combat_title: "Heroes' Ascent",
        zaishen_combat_url: URL(string: "/wiki/Heroes%27_Ascent_(Zaishen_quest)")!,
        zaishen_vanquish_title: "Forum Highlands",
        zaishen_vanquish_url: URL(string: "/wiki/Forum_Highlands_(Zaishen_vanquish)")!
    )

    private static var activity2 = DayActivity(
        date: dateCreator(year: 2023, month: 6, day: 4),
        nicholas_sandford_title: "Red Iris Flowers",
        nicholas_sandford_url: URL(string: "/wiki/Red_Iris_Flower")!,
        vanguard_quest_title: "Undead",
        vanguard_quest_url: URL(string: "/wiki/Vanguard_Annihilation:_Undead")!,
        shining_blade_title: "Justiciar Kasandra",
        shining_blade_url: URL(string: "/wiki/Wanted:_Justiciar_Kasandra")!,
        zaishen_mission_title: "Sunjiang District",
        zaishen_mission_url: URL(string: "/wiki/Sunjiang_District_(Zaishen_quest)")!,
        zaishen_bounty_title: "Baubao Wavewrath",
        zaishen_bounty_url: URL(string: "/wiki/Baubao_Wavewrath_(Zaishen_quest)")!,
        zaishen_combat_title: "Fort Aspenwood",
        zaishen_combat_url: URL(string: "/wiki/Fort_Aspenwood_(Zaishen_quest)")!,
        zaishen_vanquish_title: "Drakkar Lake",
        zaishen_vanquish_url: URL(string: "/wiki/Drakkar_Lake_(Zaishen_vanquish)")!
    )

    private static var activity3 = DayActivity(
        date: dateCreator(year: 2023, month: 6, day: 5),
        nicholas_sandford_title: "Enchanted Lodestones",
        nicholas_sandford_url: URL(string: "/wiki/Enchanted_Lodestone")!,
        vanguard_quest_title: "Blazefiend Griefblade",
        vanguard_quest_url: URL(string: "/wiki/Vanguard_Bounty:_Blazefiend_Griefblade")!,
        shining_blade_title: "Vess the Disputant",
        shining_blade_url: URL(string: "/wiki/Wanted:_Vess_the_Disputant")!,
        zaishen_mission_title: "Elona Reach",
        zaishen_mission_url: URL(string: "/wiki/Elona_Reach_(Zaishen_quest)")!,
        zaishen_bounty_title: "Joffs the Mitigator",
        zaishen_bounty_url: URL(string: "/wiki/Joffs_the_Mitigator_(Zaishen_quest)")!,
        zaishen_combat_title: "Jade Quarry",
        zaishen_combat_url: URL(string: "/wiki/Jade_Quarry_(Zaishen_quest)")!,
        zaishen_vanquish_title: "Dry Top",
        zaishen_vanquish_url: URL(string: "/wiki/Dry_Top_(Zaishen_vanquish)")!
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
        return component .date!
    }
}
