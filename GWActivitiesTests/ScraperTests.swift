//
//  ScraperTests.swift
//  GWActivitiesTests
//
//  Created by Ludovic HENRY on 11/06/2023.
//

import XCTest
@testable import GWActivities

final class ScraperTests: XCTestCase {
    private var networking: NetworkingMock!
    private var scraper: Scraper!

    override func setUp() {
        super.setUp()
        networking = NetworkingMock()
        scraper = Scraper.shared
    }

// MARK: Test Scraping Day Activities

    func testScrapGoodDayActivityWebPage() async throws {
        networking.result = .success(loadFile(.dailyOK))
        let data: [DayActivity] = try await scraper.getActivities(DayActivity.self, networking: networking)
        XCTAssertEqual(data.count, 73)
        XCTAssertEqual(data[5].nicholas_sandford.title, "Spider Legs")
    }

    func testScrapBadDayActivityWebPage() async throws {
        networking.result = .success(loadFile(.dailyKO))
        do {
            _ = try await scraper.getActivities(DayActivity.self, networking: networking)
        } catch {
            XCTAssertEqual(ScraperError.failedExtractingData, error as! ScraperError)
        }
    }

// MARK: Test Scraping Week Activities

    func testScrapGoodWeekActivityWebPage() async throws {
        networking.result = .success(loadFile(.weklyOK))
        let data: [WeekActivity] = try await scraper.getActivities(WeekActivity.self, networking: networking)
        XCTAssertEqual(data.count, 12)
        XCTAssertEqual(data[2].nicholas_location.title, "Barbarous Shore")
    }

    func testScrapBadWeekActivityWebPage() async throws {
        networking.result = .success(loadFile(.weeklyKO))
        do {
            _ = try await scraper.getActivities(DayActivity.self, networking: networking)
        } catch {
            XCTAssertEqual(ScraperError.failedExtractingData, error as! ScraperError)
        }
    }


// MARK: Test getting lastest Activity

    func testFindingLastestActivityWithGoodData() throws {
        let activities = Activities(dayActivities: DayActivity.fakeData, weekActivities: WeekActivity.fakeData)
        do {
            let lastestActivities = try scraper.getLastestActivities(activities: activities, for: .now)
            XCTAssertEqual(Date.now.toString, lastestActivities.dayActivity.date.toString)
            XCTAssertEqual("Alliance Battle", lastestActivities.weekActivity.pvp_bonus.title)
            XCTAssertEqual("Heroes' Ascent", lastestActivities.dayActivity.zaishen_combat.title)
            XCTAssertEqual(Date.now.toString, lastestActivities.weekActivity.week_starting.toString)
        } catch {
            XCTFail("Failed Test")
        }
    }

    func testFindingLastestActivityWithWrongData() throws {
        let activities = Activities(dayActivities: [], weekActivities: [])
        do {
            let _ = try scraper.getLastestActivities(activities: activities, for: .now)
        } catch {
            XCTAssertEqual(ScraperError.noLastActivities, error as! ScraperError)
        }
    }

    
}

extension ScraperTests {

    enum FakeData { case dailyOK, dailyKO, weklyOK, weeklyKO
    }

    private func loadFile(_ fakeType: FakeData) -> Data {
        var result = Data()
        var fileName = ""
        switch fakeType {
        case .dailyOK:
            fileName = "FakeDayOK"
        case .dailyKO:
            return result
        case .weklyOK:
            fileName = "FakeWeekOK"
        case .weeklyKO:
            return result
        }
        let bundleDoingTest = Bundle(for: type(of: self ))
        let path = bundleDoingTest.path(forResource: fileName, ofType: "html")
            do {
                result = try Data(contentsOf: URL(filePath: path!))
            } catch {
                print("nil")
            }
        return result
    }
}
