//
//  Scraper.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 09/06/2023.
//

import Foundation
import SwiftSoup

final class Scraper {

    static func getDailyActivities() async throws -> [DayActivity] {
        let scrapedData = try await scrapData()
        let jsonData = try dataToJSON(data: scrapedData)
        let result = try jsonToStruct(data: jsonData)
        return result
    }

    private static func scrapData() async throws -> [[String:Any]] {
        var descriptions: [[String:Any]] = []
        var tableData: [Element] = try await getTableData()
        let headings: [String] = try await getHeadings(tableData: tableData)
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
                    dictionnaryLine[heading] = try stringToDate_iso(strDate: textCell)
                }
            }
            dictionnaryLine["id"] = UUID().uuidString
            descriptions.append(dictionnaryLine)
        }
        return descriptions
    }


    private static func dataToJSON(data: [[String:Any]]) throws -> Data {
        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        return jsonData
    }

    private static func jsonToStruct(data: Data) throws -> [DayActivity] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let informations = try decoder.decode([DayActivity].self, from: data)
        return informations
    }

    private static func stringToDate_iso(strDate: String) throws -> String {
        let dateElements: [String] = strDate.components(separatedBy: " ")
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


    private static func getTableData() async throws -> [Element] {
        guard let url = URL(string: "https://wiki.guildwars.com/wiki/Daily_activities") else {fatalError("Missing URL")}
        let urlRequest = URLRequest(url: url)
        let (data, responce) = try await URLSession.shared.data(for: urlRequest)
        guard (responce as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data")}
        let strdata = String(String(decoding: data, as: UTF8.self))
        let docSoup: Document = try SwiftSoup.parse(strdata)
        let table: Elements = try docSoup.getElementsByTag("table")
        let tableData = table[0]
        var result: [Element] = []
        for tr in try! tableData.select("tr") {
            result.append(tr)
        }
        return result
    }

    private static func getHeadings(tableData: [Element]) async throws -> [String] {
        var headings: [String] = []
        for th in try tableData[0].getElementsByTag("th") {
            headings.append(try th.text(trimAndNormaliseWhitespace: true))
        }
        return headings
    }
}
