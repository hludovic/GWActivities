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
    var dateString: String {
        return date.formatted(date: .long, time: .omitted)
    }
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

    func isEqual(to toDate: Date, toGranularity component: Calendar.Component) -> Bool {
        Calendar.current.isDate(date, equalTo: toDate, toGranularity: component)
    }
}

extension DayActivity {

    static var placeholder: DayActivity {
        return DayActivity(
            id: UUID(),
            date: Date(),
            nicholas_sandford: DayActivity.Nicholas_Sandford(
                title: " ", url: URL(string: "/wiki/")!),
            vanguard_quest: DayActivity.Vanguard_Quest(
                title: " ", url: URL(string: "/wiki/")!),
            shining_blade: DayActivity.Shining_Blade(
                title: " ", url: URL(string: "/wiki/")!),
            zaishen_mission: DayActivity.Zaishen_Mission(
                title: " ", url: URL(string: "/wiki/")!),
            zaishen_bounty: DayActivity.Zaishen_Bounty(
                title: " ", url: URL(string: "/wiki/")!),
            zaishen_combat: DayActivity.Zaishen_Combat(
                title: " ", url: URL(string: "/wiki/")!),
            zaishen_vanquish: DayActivity.Zaishen_Vanquish(
                title: " ", url: URL(string: "/wiki/")!)
        )
    }

    static var fakeData: [DayActivity] {
        let dayActivity1 = DayActivity(
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

        let dayActivity2 = DayActivity(
            id: UUID(),
            date: Date.dateCreator(year: 2023, month: 6, day: 4),
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

        let dayActivity3 = DayActivity(
            id: UUID(),
            date: Date.dateCreator(year: 2023, month: 6, day: 5),
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
        return [dayActivity1, dayActivity2, dayActivity3]
    }
}
