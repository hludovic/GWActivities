//
//  ScraperTests.swift
//  GWActivitiesTests
//
//  Created by Ludovic HENRY on 11/06/2023.
//

import XCTest
@testable import GWActivities

class NetworkingMock: Networking {
    var result = Result<Data, Error>.success(Data())

    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        try (result.get(), URLResponse())
    }
}

enum FakeData {
    case dailyOK, dailyKO, weklyOK, weeklyKO
}

final class ScraperTests: XCTestCase {
    private var networking: NetworkingMock!

    override func setUp() {
        super.setUp()
        networking = NetworkingMock()
    }

// MARK: Test Scraping Day Activity

    func testScrapGoodDayActivityWebPage() async throws {
        networking.result = .success(loadFile(.dailyOK))
        let data: [DayActivity] = try await Scraper.getActivities(DayActivity.self, networking: networking)
        XCTAssertEqual(data.count, 73)
        XCTAssertEqual(data[5].nicholas_sandford.title, "Spider Legs")
    }

    func testScrapBadDayActivityWebPage() async throws {
        networking.result = .success(loadFile(.dailyKO))
        do {
            _ = try await Scraper.getActivities(DayActivity.self, networking: networking)
        } catch {
            XCTAssertEqual(ScraperError.failedExtractingData, error as! ScraperError)
        }
    }

// MARK: Test Scraping Day Activity

    func testScrapGoodWeekActivityWebPage() async throws {
        networking.result = .success(loadFile(.weklyOK))
        let data: [WeekActivity] = try await Scraper.getActivities(WeekActivity.self, networking: networking)
        XCTAssertEqual(data.count, 12)
        XCTAssertEqual(data[2].nicholas_location.title, "Barbarous Shore")
    }

    func testScrapBadWeekActivityWebPage() async throws {
        networking.result = .success(loadFile(.weeklyKO))
        do {
            _ = try await Scraper.getActivities(DayActivity.self, networking: networking)
        } catch {
            XCTAssertEqual(ScraperError.failedExtractingData, error as! ScraperError)
        }
    }
}

extension ScraperTests {

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
