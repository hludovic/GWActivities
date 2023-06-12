//
//  Scraper.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 09/06/2023.
//

import Foundation
import SwiftSoup

final class Scraper {

    private init() { }

    /// Use this method to download and format the content of a wiki that contains daily or weekly activities.
    /// - Parameter type: Accept only type DayActivity or WeekActivity.
    /// - Returns: An array of [DayActivity] or [WeekActivity] downloaded.
    static func getActivities<T: Decodable>(_ type: T.Type) async throws -> Array<T> {
        let activity: Activity
        if T.self == DayActivity.self {
            activity = .daily
        } else if T.self == WeekActivity.self {
            activity = .weekly
        } else {
            fatalError("Generic parameter not allowed")
        }
        let scrapedData: [[String:Any]] = try await scrapData(of: activity)
        let jsonData: Data = try jsonFormated(data: scrapedData)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let informations = try decoder.decode([T].self, from: jsonData)
        return informations
    }
}

private extension Scraper {

    static func scrapData(of activity: Activity) async throws -> [[String:Any]] {
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
                if let linkCell = try? tableCell.select("a").first()  {
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

    static func jsonFormated(data: [[String:Any]]) throws -> Data {
        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        return jsonData
    }

    static func extractTable(stringData: String) async throws -> [Element] {
        let docSoup: Document = try SwiftSoup.parse(stringData)
        let table: Elements = try docSoup.getElementsByTag("table")
        let tableData = table[0]
        var result: [Element] = []
        for tr in try! tableData.select("tr") {
            result.append(tr)
        }
        return result
    }

    static func extractHeadings(tableData: [Element]) async throws -> [String] {
        var headings: [String] = []
        for th in try tableData[0].getElementsByTag("th") {
            headings.append(try th.text(trimAndNormaliseWhitespace: true))
        }
        return headings
    }

    static func getWebPageData(url: URL?) async throws -> String {
        guard let url  else {fatalError("Missing URL")}
        let urlRequest = URLRequest(url: url)
        let (data, responce) = try await URLSession.shared.data(for: urlRequest)
        guard (responce as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data")}
        let stringData = String(String(decoding: data, as: UTF8.self))
        return stringData
    }

    static func dateFormated(_ stringDate: String) throws -> String {
        let dateElements: [String] = stringDate.components(separatedBy: " ")
        guard dateElements.count == 3 else { fatalError("Error date")}
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
        guard year != 0, month != 0, day != 0 else { fatalError("Date casting failed") }
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        guard let result = Calendar.current.date(from: dateComponents) else { fatalError("Unable to create date") }
        return result.ISO8601Format()
    }
}

enum ScraperError: Error {
    case failedCasting, failedFetching
    var description: String {
        switch self {
        case .failedCasting:
            return "Date casting failed"
        case .failedFetching:
            return "Error while fetching data"
        }
    }
}
