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
        networking = NetworkingMock()
    }

    // MARK: Test Scraping Day Activity

    func testDownloadDaylyActivities() async throws {
        XCTAssertEqual(viewModel.dayActivities.count, 0)
        XCTAssertEqual(viewModel.isExportdisabled, true)
        viewModel.isOnline = true

        networking.result = .success(loadFile(.dailyOK))
        viewModel.selectedActivity = .daily
        await viewModel.pressRefreshButton(networking: networking)

        XCTAssertEqual(viewModel.dayActivities.count, 73)
        XCTAssertEqual(viewModel.dayActivities[5].nicholas_sandford.title, "Spider Legs")
        XCTAssertEqual(viewModel.isExportdisabled, false)
        XCTAssertEqual(viewModel.errorMessage, "")

    }

    func testDownloadBadDayActivity() async throws {
        XCTAssertEqual(viewModel.dayActivities.count, 0)
        XCTAssertEqual(viewModel.isExportdisabled, true)
        viewModel.isOnline = true

        networking.result = .success(loadFile(.dailyKO))
        viewModel.selectedActivity = .daily
        await viewModel.pressRefreshButton(networking: networking)

        XCTAssertEqual(viewModel.dayActivities.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "Unable to download the activities")
        XCTAssertEqual(viewModel.isExportdisabled, true)

    }

    func testDownloadWrongDayActivity() async throws {
        XCTAssertEqual(viewModel.dayActivities.count, 0)
        XCTAssertEqual(viewModel.isExportdisabled, true)
        viewModel.isOnline = true

        networking.result = .success(loadFile(.dailyWrong))
        viewModel.selectedActivity = .daily
        await viewModel.pressRefreshButton(networking: networking)

        XCTAssertEqual(viewModel.dayActivities.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "Unable to download the activities")
        XCTAssertEqual(viewModel.isExportdisabled, true)
    }

    // MARK: Test Scraping Week Activity

    func testDownloadWeeklyActivities() async throws {
        XCTAssertEqual(viewModel.weekActivities.count, 0)
        XCTAssertEqual(viewModel.isExportdisabled, true)
        viewModel.isOnline = true

        networking.result = .success(loadFile(.weklyOK))
        viewModel.selectedActivity = .weekly
        await viewModel.pressRefreshButton(networking: networking)

        XCTAssertEqual(viewModel.weekActivities.count, 12)
        XCTAssertEqual(viewModel.weekActivities[2].nicholas_location.title, "Barbarous Shore")
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertEqual(viewModel.isExportdisabled, false)
    }

    func testDownloadBadWeekActivity() async throws {
        XCTAssertEqual(viewModel.weekActivities.count, 0)
        XCTAssertEqual(viewModel.isExportdisabled, true)
        viewModel.isOnline = true

        networking.result = .success(loadFile(.weeklyKO))
        viewModel.selectedActivity = .weekly
        await viewModel.pressRefreshButton(networking: networking)

        XCTAssertEqual(viewModel.weekActivities.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "Unable to download the activities")
        XCTAssertEqual(viewModel.isExportdisabled, true)
    }

    func testDownloadWrongWeekActivity() async throws {
        XCTAssertEqual(viewModel.weekActivities.count, 0)
        XCTAssertEqual(viewModel.isExportdisabled, true)
        viewModel.isOnline = true

        networking.result = .success(loadFile(.weeklyWrong))
        viewModel.selectedActivity = .weekly
        await viewModel.pressRefreshButton(networking: networking)

        XCTAssertEqual(viewModel.weekActivities.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "Unable to download the activities")
        XCTAssertEqual(viewModel.isExportdisabled, true)
    }

    // MARK: Test Scraping Offline

    func testDownloadWeekActivityOffline() async throws {
        XCTAssertEqual(viewModel.weekActivities.count, 0)
        XCTAssertEqual(viewModel.isExportdisabled, true)
        viewModel.isOnline = false

        networking.result = .success(loadFile(.dailyOK))
        viewModel.selectedActivity = .weekly
        await viewModel.pressRefreshButton(networking: networking)

        XCTAssertEqual(viewModel.weekActivities.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "Error: You are offline\n Try to connect before to refresh")
        XCTAssertEqual(viewModel.isExportdisabled, true)
    }

    // MARK: Test Scraping Month Activity

    func testDownloadMonthActivity() async throws {
        XCTAssertEqual(viewModel.isExportdisabled, true)
        viewModel.isOnline = true

        viewModel.selectedActivity = .monthly
        await viewModel.pressRefreshButton(networking: networking)

        XCTAssertEqual(viewModel.errorMessage, "Error: Refreshing Monthly activities is not implemented")
        XCTAssertEqual(viewModel.isExportdisabled, true)
    }

    // MARK: Test Scraping Month Activity

    func testDownloadEvents() async throws {
        XCTAssertEqual(viewModel.isExportdisabled, true)
        viewModel.isOnline = true

        viewModel.selectedActivity = .events
        await viewModel.pressRefreshButton(networking: networking)

        XCTAssertEqual(viewModel.errorMessage, "Error: Refreshing Events is not implemented")
        XCTAssertEqual(viewModel.isExportdisabled, true)
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
