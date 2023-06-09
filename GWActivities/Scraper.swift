//
//  Scraper.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 09/06/2023.
//

import Foundation
import SwiftSoup

final class Scraper {

    static func maintStuff() async throws {
        let data = try await scrapData()
        try dataToJSON(data: data)
    }

    static func scrapData() async throws -> [[String:Any]] {
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
                    dictionnaryLine[heading] = textCell
                }
            }
            descriptions.append(dictionnaryLine)
        }
        return descriptions
    }


    static func dataToJSON(data: [[String:Any]]) throws {
        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        print(String(data: jsonData, encoding: .utf8) ?? "ERROR")
    }


    static func getTableData() async throws -> [Element] {
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
