//
//  Scraper.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 09/06/2023.
//

import Foundation
import SwiftSoup
import os

typealias Activities = (dayActivities: [DayActivity], weekActivities: [WeekActivity])
typealias LastestActivities = (dayActivity: DayActivity, weekActivity: WeekActivity)

final class Scraper {
    private var networking: Networking = URLSession.shared
    static let shared = Scraper()

    private init() { }

    /// Use this method to download and format the content of a wiki that contains daily or weekly activities.
    /// - Parameter type: Accept only type DayActivity or WeekActivity.
    /// - Returns: An array of [DayActivity] or [WeekActivity] downloaded.
    func getActivities<T: Decodable>(_ type: T.Type, networking: Networking = URLSession.shared) async throws -> Array<T> {
        self.networking = networking
        let activity: Activity
        if T.self == DayActivity.self {
            activity = .daily
        } else if T.self == WeekActivity.self {
            activity = .weekly
        } else {
            throw ScraperError.failedGettingGeneric
        }
        let scrapedData: [[String:Any]] = try await scrapData(of: activity)
        let jsonData: Data = try jsonFormated(data: scrapedData)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let informations = try decoder.decode([T].self, from: jsonData)
        return informations
    }

    func getLastestActivities(activities: Activities, for day: Date) throws -> LastestActivities {
        var today: DayActivity? = nil
        var thisWeek: WeekActivity? = nil
        for dayActivity in activities.dayActivities {
            if dayActivity.date.isInSameDay(as: day) {
                today = dayActivity
            }
        }
        for weekActivity in activities.weekActivities {
            if weekActivity.week_starting.isInSameWeek(as: day) {
                thisWeek = weekActivity
            }
        }
        guard let today, let thisWeek else { throw ScraperError.noLastActivities }
        return LastestActivities(dayActivity: today, weekActivity: thisWeek)
    }
}

private extension Scraper {

    func dailyRefreshTimeFromUTC() -> Date {
        var dateComponent = DateComponents()
        dateComponent.day = Calendar.current.component(.day, from: .now)
        dateComponent.month = Calendar.current.component(.month, from: .now)
        dateComponent.year = Calendar.current.component(.year, from: .now)
        dateComponent.calendar = .current
        dateComponent.timeZone = .gmt
        dateComponent.hour = 16
        return Calendar.current.date(from: dateComponent)!
    }

    func scrapData(of activity: Activity) async throws -> [[String:Any]] {
        var descriptions: [[String:Any]] = []
        let stringData: String = try await getWebPageData(url: activity.url)
        var tableData: [Element] = try await extractTable(stringData: stringData)
        let headings: [String] = try await extractHeadings(tableData: tableData)
        tableData.removeFirst(1)
        for line in tableData {
            let tableCells = try line.getElementsByTag("td")
            var dictionnaryLine: [String:Any] = [:]
            for (heading, tableCell) in zip(headings, tableCells) {
                let heading = heading.lowercased().replacingOccurrences(of: " ", with: "_")
                let textCell = try tableCell.text(trimAndNormaliseWhitespace: true)
                if let linkCell = try? tableCell.select("a").first() {
                    let masterLink = try linkCell.attr("href")
                    let dictionnaryCell = ["title": textCell, "url": masterLink]
                    dictionnaryLine[heading] = dictionnaryCell
                } else {
                    if (heading == "date" || heading == "week_starting") {
                        dictionnaryLine[heading] = try dateFormated(textCell)
                    } else {
                        let dictionnaryCell = ["title": textCell, "url": "/wiki/"]
                        dictionnaryLine[heading] = dictionnaryCell
                    }
                }
            }
            dictionnaryLine["id"] = UUID().uuidString
            descriptions.append(dictionnaryLine)
        }
        return descriptions
    }

    func jsonFormated(data: [[String:Any]]) throws -> Data {
        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        return jsonData
    }

    func extractTable(stringData: String) async throws -> [Element] {
        let docSoup: Document = try SwiftSoup.parse(stringData)
        let table: Elements = try docSoup.getElementsByTag("table")
        guard table.count > 0 else { throw ScraperError.failedExtractingData }
        let tableData = table[0]
        var result: [Element] = []
        for tr in try! tableData.select("tr") {
            result.append(tr)
        }
        return result
    }

    func extractHeadings(tableData: [Element]) async throws -> [String] {
        var headings: [String] = []
        for th in try tableData[0].getElementsByTag("th") {
            headings.append(try th.text(trimAndNormaliseWhitespace: true))
        }
        return headings
    }

    func getWebPageData(url: URL?) async throws -> String {
        guard let url  else { throw ScraperError.failedReadingURL }
        let (data, _) = try await networking.data(from: url)
        let stringData = String(String(decoding: data, as: UTF8.self))
        return stringData
    }

    func dateFormated(_ stringDate: String) throws -> String {
        let dateElements: [String] = stringDate.components(separatedBy: " ")
        guard dateElements.count == 3 else { throw ScraperError.failedReadingDate }
        var month = 0
        switch dateElements[1].lowercased() {
        case "january":
            month = 1
        case "february":
            month = 2
        case "march":
            month = 3
        case "april":
            month = 4
        case "may":
            month = 5
        case "june":
            month = 6
        case "july":
            month = 7
        case "august":
            month = 8
        case "september":
            month = 9
        case "october":
            month = 10
        case "november":
            month = 11
        case "december":
            month = 12
        default:
            month = 0
        }
        let day: Int = Int(dateElements[0]) ?? 0
        let year: Int = Int(dateElements[2]) ?? 0
        guard year != 0, month != 0, day != 0 else { throw ScraperError.failedFormatingDate }
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        guard let result = Calendar.current.date(from: dateComponents) else { throw ScraperError.failedFormatingDate }
        return result.ISO8601Format()
    }
}

enum ScraperError: Error {
    case failedFormatingDate, failedReadingDate, failedReadingURL, failedExtractingData, failedGettingGeneric, noLastActivities
    var description: String {
        switch self {
        case .failedReadingDate:
            return "This date format is not formattable"
        case .failedFormatingDate:
            return "Failed when formating a date"
        case .failedReadingURL:
            return "Error when reading a rwong URL"
        case .failedExtractingData:
            return "The wiki returns no data"
        case .failedGettingGeneric:
            return "Error, the generic parapetre is neither DayActivity nor WeekActivity"
        case .noLastActivities:
            return "No activities found when trying to get last activities"
        }
    }
}
