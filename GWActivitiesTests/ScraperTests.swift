//
//  ScraperTests.swift
//  GWActivitiesTests
//
//  Created by Ludovic HENRY on 11/06/2023.
//

import XCTest
@testable import GWActivities

final class ScraperTests: XCTestCase {

    func testLoadDayActivity() async throws {
        let data: [DayActivity] = try await Scraper.getActivities(DayActivity.self)
        XCTAssertNotEqual(data.count, 0)
    }

    func testLoadWeekActivity() async throws {
        let data: [WeekActivity] = try await Scraper.getActivities(WeekActivity.self)
        XCTAssertNotEqual(data.count, 0)
    }
}
