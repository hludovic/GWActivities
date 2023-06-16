//
//  ContentViewModel.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 10/06/2023.
//

import Foundation
import os

class ContentViewModel: ObservableObject {
    private let taskID: UUID = UUID()
    @Published var dayActivities: [DayActivity]
    @Published var weekActivities: [WeekActivity]
    @Published var isLoading: Bool
    @Published var lineSelected: DayActivity.ID?
    @Published var currentDayLineID: DayActivity.ID?
    @Published var currentWeekLineID: DayActivity.ID?
    @Published var selectedActivity: Activity
    @Published var errorMessage: String
    @Published var displayAlert: Bool
    private let scraper = Scraper.shared
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: ContentViewModel.self))

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
    }

    func downloadDailyActivities() async {
        logger.info("Started downloading daily activities - Task \(self.taskID)")
        await MainActor.run { isLoading = true }
        do {
            let requestResult: [DayActivity] = try await scraper.getActivities(DayActivity.self)
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

    func downloadWeeklyActivities() async {
        logger.info("Started downloading weekly activities - Task \(self.taskID)")
        await MainActor.run { isLoading = true }
        do {
            let requestResult: [WeekActivity] = try await scraper.getActivities(WeekActivity.self)
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

    @MainActor func displayError(message: String) {
        errorMessage = message
        displayAlert = true
    }
}
