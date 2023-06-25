//
//  ContentVMTests.swift
//  GWActivitiesTests
//
//  Created by Ludovic HENRY on 15/06/2023.
//

import XCTest
@testable import GWActivities

final class ContentVMTests: XCTestCase {
    private var viewModel: ContentViewModel!
    private var networking: NetworkingMock!

    override func setUp() {
        super.setUp()
        viewModel = ContentViewModel()
        viewModel.isOnline = true
        networking = NetworkingMock()
    }

    // MARK: Test Scraping Day Activity

    func testDownloadDaylyActivities() async throws {
        XCTAssertEqual(viewModel.dayActivities.count, 0)

        networking.result = .success(loadFile(.dailyOK))
        viewModel.selectedActivity = .daily
        await viewModel.pressRefreshButton(networking: networking)

        XCTAssertEqual(viewModel.dayActivities.count, 73)
        XCTAssertEqual(viewModel.dayActivities[5].nicholas_sandford.title, "Spider Legs")
    }

    func testDownloadBadDayActivity() async throws {
        XCTAssertEqual(viewModel.dayActivities.count, 0)

        networking.result = .success(loadFile(.dailyKO))
        viewModel.selectedActivity = .daily
        await viewModel.pressRefreshButton(networking: networking)

        XCTAssertEqual(viewModel.dayActivities.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "Unable to download the activities")
    }

    func testDownloadWrongDayActivity() async throws {
        XCTAssertEqual(viewModel.dayActivities.count, 0)

        networking.result = .success(loadFile(.dailyWrong))
        viewModel.selectedActivity = .daily
        await viewModel.pressRefreshButton(networking: networking)

        XCTAssertEqual(viewModel.dayActivities.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "Unable to download the activities")
    }

    // MARK: Test Scraping Week Activity

    func testDownloadWeeklyActivities() async throws {
        XCTAssertEqual(viewModel.weekActivities.count, 0)

        networking.result = .success(loadFile(.weklyOK))
        viewModel.selectedActivity = .weekly
        await viewModel.pressRefreshButton(networking: networking)

        XCTAssertEqual(viewModel.weekActivities.count, 12)
        XCTAssertEqual(viewModel.weekActivities[2].nicholas_location.title, "Barbarous Shore")
    }

    func testDownloadBadWeekActivity() async throws {
        XCTAssertEqual(viewModel.weekActivities.count, 0)

        networking.result = .success(loadFile(.weeklyKO))
        viewModel.selectedActivity = .weekly
        await viewModel.pressRefreshButton(networking: networking)

        XCTAssertEqual(viewModel.weekActivities.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "Unable to download the activities")
    }

    func testDownloadWrongWeekActivity() async throws {
        XCTAssertEqual(viewModel.weekActivities.count, 0)

        networking.result = .success(loadFile(.weeklyWrong))
        viewModel.selectedActivity = .weekly
        await viewModel.pressRefreshButton(networking: networking)

        XCTAssertEqual(viewModel.weekActivities.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "Unable to download the activities")
    }
}

extension ContentVMTests {

    enum FakeData { case dailyOK, dailyKO, dailyWrong, weklyOK, weeklyKO, weeklyWrong }

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
        case .dailyWrong:
            fileName = "FakeDayWrong"
        case .weeklyWrong:
            fileName = "FakeWeekWrong"
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
