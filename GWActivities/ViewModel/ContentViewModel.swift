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
    @Published var dayActivities: [DayActivity] = [] {
        didSet { isExportdisabled = canPressExport() ? false : true }
    }
    @Published var weekActivities: [WeekActivity] = [] {
        didSet { isExportdisabled = canPressExport() ? false : true }
    }
    @Published var isLoading: Bool = false
    @Published var lineSelected: DayActivity.ID? = nil
    @Published var currentDayLineID: DayActivity.ID? = nil
    @Published var currentWeekLineID: DayActivity.ID? = nil
    @Published var selectedActivity: Activity {
        didSet { isExportdisabled = canPressExport() ? false : true }
    }
    @Published var errorMessage: String = ""
    @Published var displayAlert: Bool = false
    @Published var isExporting: Bool = false
    @Published var isExportdisabled: Bool = true
    @Published var document: ActivityDocument = ActivityDocument()
    @Published var exportResult: Result<URL, Error>? {
        didSet { processExportResult(result: exportResult) }
    }
    private let scraper = Scraper.shared
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: ContentViewModel.self))

    // MARK: Network monitoring properties
    private let monitor: NWPathMonitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    var isOnline = false

    init(activity: Activity = .daily) {
        self.selectedActivity = activity
        // Network monitoring init
        monitor.pathUpdateHandler = { path in
            self.isOnline = path.status == .satisfied
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
        monitor.start(queue: queue)
    }

    func pressRefreshButton(networking: Networking = URLSession.shared) async {
        if isOnline {
            if selectedActivity == .daily {
                await downloadDailyActivities(networking: networking)
            } else if selectedActivity == .weekly {
                await downloadWeeklyActivities(networking: networking)
            } else {
                logger.error("Error: Refreshing \(self.selectedActivity.name) is not implemented - Task \(self.taskID)")
            }
        } else {
            logger.error("Unable to refresh offline - Task \(self.taskID)")
            return displayError(message: "Error: You are offline\n Try to connect before to refresh")
        }
    }

    func pressExportButton() {
        guard canPressExport() else { return }
        exportResult = nil
        let csvString: String
        logger.info("Start exporting a \(self.selectedActivity.name) - Task \(self.taskID)")
        if selectedActivity == .daily {
            do {
                csvString = try CsvEncoder.encode(dayActivities)
            } catch {
                logger.error("Failed to encode the DayActivities document \(error.localizedDescription) - Task \(self.taskID)")
                return displayError(message: "Failed to save the document")
            }
        } else if selectedActivity == .weekly {
            do {
                csvString = try CsvEncoder.encode(weekActivities)
            } catch {
                logger.error("Failed to encode the WeekActivities document \(error.localizedDescription) - Task \(self.taskID)")
                return displayError(message: "Failed to save the document")
            }
        } else {
            return logger.error("Error: Encoding \(self.selectedActivity.name) is not implemented - Task \(self.taskID)")
        }
        document.message = csvString
        isExporting = true
    }
}

private extension ContentViewModel {

    func displayError(message: String) {
        errorMessage = message
        displayAlert = true
    }

    func processExportResult(result: Result<URL, Error>?) {
        guard let result else { return }
        switch result {
        case .failure(let error):
            logger.error("Failed to Csv export \(error.localizedDescription) - Task \(self.taskID)")
            exportResult = nil
            return displayError(message: "Failed to save the document")
        case .success(let url):
            logger.info("File saved to: \(url.absoluteString) - Task \(self.taskID)")
            return exportResult = nil
        }
    }

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

    func downloadDailyActivities(networking: Networking) async {
        logger.info("Started downloading daily activities - Task \(self.taskID)")
        await MainActor.run { isLoading = true }
        do {
            let requestResult: [DayActivity] = try await scraper.getActivities(DayActivity.self, networking: networking)
            await MainActor.run {
                logger.info("Finished downloading daily activities - Task \(self.taskID)")
                isLoading = false
                dayActivities = requestResult
            }
            for activity in dayActivities {
                if activity.date.isInSameDay(as: .now) {
                    await MainActor.run {
                        currentDayLineID = activity.id
                    }
                }
            }
        } catch (let error) {
            logger.error("\(error.localizedDescription) - Task \(self.taskID)")
            await MainActor.run { isLoading = false }
            return displayError(message: "Unable to download the activities")
        }
    }

    func downloadWeeklyActivities(networking: Networking) async {
        logger.info("Started downloading weekly activities - Task \(self.taskID)")
        await MainActor.run { isLoading = true }
        do {
            let requestResult: [WeekActivity] = try await scraper.getActivities(WeekActivity.self, networking: networking)
            await MainActor.run {
                logger.info("Finished downloading weekly activities - Task \(self.taskID)")
                isLoading = false
                weekActivities = requestResult
            }
            for activity in weekActivities {
                if activity.week_starting.isInSameWeek(as: .now) {
                    await MainActor.run {
                        currentWeekLineID = activity.id
                    }
                }
            }
        } catch (let error) {
            logger.error("\(error.localizedDescription) - Task \(self.taskID)")
            await MainActor.run { isLoading = false }
            return displayError(message: "Unable to download the activities")
        }
    }
}
