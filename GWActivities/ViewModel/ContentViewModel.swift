//
//  ContentViewModel.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 10/06/2023.
//

import Foundation
import Network
import os

class ContentViewModel: ObservableObject {
    private let taskID: UUID = UUID()
    @Published var dayActivities: [DayActivity] {
        didSet { isExportdisabled = canPressExport() ? false : true }
    }
    @Published var weekActivities: [WeekActivity] {
        didSet { isExportdisabled = canPressExport() ? false : true }
    }
    @Published var isLoading: Bool
    @Published var lineSelected: DayActivity.ID?
    @Published var currentDayLineID: DayActivity.ID?
    @Published var currentWeekLineID: DayActivity.ID?
    @Published var selectedActivity: Activity {
        didSet { isExportdisabled = canPressExport() ? false : true }
    }
    @Published var errorMessage: String
    @Published var displayAlert: Bool
    @Published var isExporting: Bool
    @Published var isExportdisabled: Bool = true
    @Published var document: ActivityDocument = ActivityDocument(message: "Hello, World!")
    private let scraper = Scraper.shared
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: ContentViewModel.self))

    // MARK: Network monitoring properties
    private let monitor: NWPathMonitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    var isOnline = false

    init(activity: Activity = .daily) {
        self.dayActivities = []
        self.weekActivities = []
        self.isLoading = false
        self.lineSelected = nil
        self.currentDayLineID = nil
        self.currentWeekLineID = nil
        self.selectedActivity = activity
        self.errorMessage = ""
        self.displayAlert = false
        self.isExporting = false

        // Network monitoring init
        monitor.pathUpdateHandler = { path in
            self.isOnline = path.status == .satisfied
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
        monitor.start(queue: queue)
    }

    func pressRefreshButton() async {
        if isOnline {
            if selectedActivity == .daily {
                await downloadDailyActivities()
            } else if selectedActivity == .weekly {
                await downloadWeeklyActivities()
            } else {
                print("Not implemented")
            }
        } else {
            logger.error("Unable to refresh offline")
            return await displayError(message: "Error: You are offline\n Try to connect before to refresh")
        }
    }

    func pressExportButton() {
        guard canPressExport() else { return }
        let csvString: String
        if selectedActivity == .daily {
            do {
                csvString = try CsvEncoder.encodeDayActivity(activities: dayActivities)
            } catch {
                return print(error.localizedDescription)
            }
        } else if selectedActivity == .weekly {
            do {
                csvString = try CsvEncoder.encodeWeekActivity(activities: weekActivities)
            } catch {
                return print(error.localizedDescription)
            }
        } else {
            return
        }
        document.message = csvString
        isExporting = true
    }

    func downloadDailyActivities(networking: Networking? = nil) async {
        logger.info("Started downloading daily activities - Task \(self.taskID)")
        await MainActor.run { isLoading = true }
        do {
            let requestResult: [DayActivity]
            if let networking {
                requestResult = try await scraper.getActivities(DayActivity.self, networking: networking)
            } else {
                requestResult = try await scraper.getActivities(DayActivity.self)
            }
            await MainActor.run {
                logger.info("Finished downloading daily activities - Task \(self.taskID)")
                isLoading = false
                dayActivities = requestResult
            }
            for activity in dayActivities {
                if activity.isEqual(to: Date(), toGranularity: .day) {
                    await MainActor.run {
                        currentDayLineID = activity.id
                    }
                }
            }
        } catch (let error) {
            logger.error("\(error.localizedDescription) - Task \(self.taskID)")
            await MainActor.run { isLoading = false }
            return await displayError(message: "Unable to download the activities")
        }
    }

    func downloadWeeklyActivities(networking: Networking? = nil) async {
        logger.info("Started downloading weekly activities - Task \(self.taskID)")
        await MainActor.run { isLoading = true }
        do {
            let requestResult: [WeekActivity]
            if let networking {
                requestResult = try await scraper.getActivities(WeekActivity.self, networking: networking)
            } else {
                requestResult = try await scraper.getActivities(WeekActivity.self)
            }
            await MainActor.run {
                logger.info("Finished downloading weekly activities - Task \(self.taskID)")
                isLoading = false
                weekActivities = requestResult
            }
            for activity in weekActivities {
                if activity.isEqual(to: Date(), toGranularity: .weekOfYear) {
                    await MainActor.run {
                        currentWeekLineID = activity.id
                    }
                }
            }
        } catch (let error) {
            logger.error("\(error.localizedDescription) - Task \(self.taskID)")
            await MainActor.run { isLoading = false }
            return await displayError(message: "Unable to download the activities")
        }
    }

    @MainActor private func displayError(message: String) {
        errorMessage = message
        displayAlert = true
    }
}

private extension ContentViewModel {
    func canPressExport() -> Bool {
        switch selectedActivity {
        case .daily:
            return dayActivities.isEmpty ? false : true
        case .weekly:
            return weekActivities.isEmpty ? false : true
        case .monthly:
            return false
        case .events:
            return false
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
