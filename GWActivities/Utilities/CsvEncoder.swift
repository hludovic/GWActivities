//
//  CsvEncoder.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 18/06/2023.
//

import Foundation

class CsvEncoder {

    private static var dayActivityHeader: String {
        var line = "Date;"
        line += "Zaishen Mission;"
        line += "Zaishen Bounty;"
        line += "Zaishen Combat;"
        line += "Zaishen Vanquish;"
        line += "Shining Blade;"
        line += "Vanguard Quest;"
        line += "Nicholas Sandford\n"
        return line
    }

    private static var weekActivityHeader: String {
        var line = "Week starting;"
        line += "PvE bonus;"
        line += "PvP bonus;"
        line += "Nicholas item;"
        line += "Nicholas location;"
        line += "Nicholas map\n"
        return line
    }

    private init() { }

    static func encodeDayActivity(activities: [DayActivity]) throws -> String {
        guard activities.count > 0 else { fatalError("ERROR") }
        var result: String = dayActivityHeader
        for activity in activities {
            var line = "\(activity.dateString);"
            line += "\(activity.zaishen_mission.title);"
            line += "\(activity.zaishen_bounty.title);"
            line += "\(activity.zaishen_combat.title);"
            line += "\(activity.zaishen_vanquish.title);"
            line += "\(activity.shining_blade.title);"
            line += "\(activity.vanguard_quest.title);"
            line += "\(activity.nicholas_sandford.title)/n"
            result += line
        }
        return result
    }

    static func encodeWeekActivity(activities: [WeekActivity]) throws -> String {
        guard activities.count > 0 else { fatalError("ERROR") }
        var result: String = weekActivityHeader
        for activity in activities {
            var line = "\(activity.week_startingString);"
            line += "\(activity.pve_bonus.title);"
            line += "\(activity.pvp_bonus.title);"
            line += "\(activity.nicholas_item.title);"
            line += "\(activity.nicholas_location.title);"
            line += "\(activity.nicholas_map.title);"
            result += line
        }
        return result
    }

}
