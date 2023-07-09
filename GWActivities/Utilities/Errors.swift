//
//  Errors.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 09/07/2023.
//

import Foundation

enum CsvEncoderError: Error {
    case failEncodActivities, emptyActivity
    var description: String {
        switch self {
        case .emptyActivity:
            return "The array of activity you tryed to encode is empty"
        case .failEncodActivities:
            return "Failed to read the data format to be encoded"
        }
    }
}

enum ScraperError: Error {
    case failedFormatingDate, failedReadingDate, failedReadingURL, failedExtractingData, failedGettingGeneric, noLastActivities
    var description: String {
        switch self {
        case .failedReadingDate:
            return "This date format is not formattable"
        case .failedFormatingDate:
            return "Failed when formating a date"
        case .failedReadingURL:
            return "Error when reading a rwong URL"
        case .failedExtractingData:
            return "The wiki returns no data"
        case .failedGettingGeneric:
            return "Error, the generic parapetre is neither DayActivity nor WeekActivity"
        case .noLastActivities:
            return "No activities found when trying to get last activities"
        }
    }
}

enum ContentVMError: Error {
    case failedFormatingDate, failedReadingDate, failedReadingURL, failedExtractingData, failedGettingGeneric
    var description: String {
        switch self {
        case .failedReadingDate:
            return "This date format is not formattable"
        case .failedFormatingDate:
            return "Failed when formating a date"
        case .failedReadingURL:
            return "Error when reading a rwong URL"
        case .failedExtractingData:
            return "The wiki returns no data"
        case .failedGettingGeneric:
            return "Error, the generic parapetre is neither DayActivity nor WeekActivity"
        }
    }
}
