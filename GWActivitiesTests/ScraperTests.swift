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

final class ScraperTests: XCTestCase {

    private var scraper: Scraper!
    private var networking: NetworkingMock!
    private var fakeWebPage: Data!

    override func setUp() {
        super.setUp()
        networking = NetworkingMock()
        let fileName = "fakeDay"

        let path = Bundle.main.path(forResource: fileName, ofType: "html")
            do {
                fakeWebPage = try Data(contentsOf: URL(filePath: path!))
            } catch {
                print("nil")
            }
    }

    func testLoadDayActivity() async throws {
        networking.result = .success(fakeWebPage)
//        let aa = try await Scraper.getActivities(DayActivity.self, networking: networking)
//        let data: [DayActivity] = try await Scraper.getActivities(DayActivity.self)
        let data: [DayActivity] = try await Scraper.getActivities(DayActivity.self, networking: networking)
        XCTAssertEqual(data.count, 73)
        
    }

    func testLoadWeekActivity1() async throws {
        let data: [WeekActivity] = try await Scraper.getActivities(WeekActivity.self)
        XCTAssertNotEqual(data.count, 0)
    }
}
