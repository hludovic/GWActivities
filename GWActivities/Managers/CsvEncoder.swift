//
//  CsvEncoder.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 18/06/2023.
//

import Foundation

class CsvEncoder {

    private init() { }

    /// This method formats a [DayActivity] or [WeekActivity] array into csv.
    /// - Parameter activities: Accept only type [DayActivity] or [WeekActivity].
    /// - Returns: A string contains the array formatted in csv
    static func encode<Activities>(_ activities: Activities) throws -> String {
        if Activities.self == Array<DayActivity>.self {
            guard let activities = activities as? [DayActivity] else { throw CsvEncoderError.failEncodActivities }
            return try encodeDayActivity(activities: activities)
        } else if Activities.self == Array<WeekActivity>.self {
            guard let activities = activities as? [WeekActivity] else { throw CsvEncoderError.failEncodActivities }
            return try encodeWeekActivity(activities: activities)
        }
        throw CsvEncoderError.failEncodActivities
    }
}

private extension CsvEncoder {
    // MARK: - private methods
    static func encodeDayActivity(activities: [DayActivity]) throws -> String {
        guard activities.count > 0 else { throw CsvEncoderError.emptyActivity }
        var result: String = getDayActivityHeader()
        for activity in activities {
            var line = "\(activity.date.toString);"
            line += "\(activity.zaishen_mission.title);"
            line += "\(activity.zaishen_bounty.title);"
            line += "\(activity.zaishen_combat.title);"
            line += "\(activity.zaishen_vanquish.title);"
            line += "\(activity.shining_blade.title);"
            line += "\(activity.vanguard_quest.title);"
            line += "\(activity.nicholas_sandford.title)\n"
            result += line
        }
        return result
    }

    static func encodeWeekActivity(activities: [WeekActivity]) throws -> String {
        guard activities.count > 0 else { throw CsvEncoderError.emptyActivity }
        var result: String = getWeekActivityHeader()
        for activity in activities {
            var line = "\(activity.week_starting.toString);"
            line += "\(activity.pve_bonus.title);"
            line += "\(activity.pvp_bonus.title);"
            line += "\(activity.nicholas_item.title);"
            line += "\(activity.nicholas_location.title);"
            line += "\(activity.nicholas_map.title)\n"
            result += line
        }
        return result
    }

    static func getDayActivityHeader() -> String {
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

    static func getWeekActivityHeader() -> String {
        var line = "Week starting;"
        line += "PvE bonus;"
        line += "PvP bonus;"
        line += "Nicholas item;"
        line += "Nicholas location;"
        line += "Nicholas map\n"
        return line
    }
}
