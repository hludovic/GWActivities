//
//  CsvEncoderTests.swift
//  GWActivitiesTests
//
//  Created by Ludovic HENRY on 25/06/2023.
//

import XCTest
@testable import GWActivities

final class CsvEncoderTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testWrongFormatDataEncoding() throws {
        do {
            let wrongData: String = "Wrong Data"
            let _ = try CsvEncoder.encode(wrongData)
        } catch let error{
            XCTAssertEqual(CsvEncoderError.failEncodActivities, error as! CsvEncoderError)
        }
    }

    func testEncodeEmptyArray() throws {
        do {
            let emptyDayArray: [DayActivity] = []
            let _ = try CsvEncoder.encode(emptyDayArray)

        } catch {
            XCTAssertEqual(CsvEncoderError.emptyActivity, error as! CsvEncoderError)
        }

        do {
            let emptyWeekArray: [WeekActivity] = []
            let _ = try CsvEncoder.encode(emptyWeekArray)
        } catch let error{
            XCTAssertEqual(CsvEncoderError.emptyActivity, error as! CsvEncoderError)
        }
    }

    func testEncodeGoodData() throws {
        do {
            let dayActivityData: [DayActivity] = DayActivity.fakeData
            let weekActivityData: [WeekActivity] = WeekActivity.fakeData
            let _ = try CsvEncoder.encode(dayActivityData)
            let _ = try CsvEncoder.encode(weekActivityData)
        } catch let error{
            XCTFail(error.localizedDescription)
        }
    }
}
