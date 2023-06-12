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
    @Published var dayActivities: [DayActivity] = []
    @Published var weekActivities: [WeekActivity] = []
    @Published var isLoading: Bool = false
    @Published var lineSelected: DayActivity.ID? = nil
    @Published var currentDayLineID: DayActivity.ID? = nil
    @Published var selectedActivity: Activity = .daily
    @Published var errorMessage: String = ""
    @Published var displayAlert: Bool = false
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: ContentViewModel.self))

    func downloadDailyActivities() async {
        logger.info("Started downloading daily activities - Task \(self.taskID)")
        await MainActor.run { isLoading = true }
        do {
            let requestResult: [DayActivity] = try await Scraper.getActivities(DayActivity.self)
            await MainActor.run {
                logger.info("Finished downloading daily activities - Task \(self.taskID)")
                isLoading = false
                dayActivities = requestResult
            }
            for activity in dayActivities {
                if activity.isSameDayThan(date: Date()) {
                    await MainActor.run {
                        currentDayLineID = activity.id
                    }
                }
            }
        } catch (let error) {
            logger.error("\(error.localizedDescription) - Task \(self.taskID)")
            isLoading = false
            return await displayError(message: "Unable to download the activities")
        }
    }

    func downloadWeeklyActivities() async {
        logger.info("Started downloading weekly activities - Task \(self.taskID)")
        await MainActor.run { isLoading = true }
        do {
            let requestResult: [WeekActivity] = try await Scraper.getActivities(WeekActivity.self)
            await MainActor.run {
                logger.info("Finished downloading weekly activities - Task \(self.taskID)")
                isLoading = false
                weekActivities = requestResult
            }
            for activity in dayActivities {
                if activity.isSameDayThan(date: Date()) {
                    await MainActor.run {
                        lineSelected = activity.id
                    }
                }
            }
        } catch (let error) {
            logger.error("\(error.localizedDescription) - Task \(self.taskID)")
            isLoading = false
            return await displayError(message: "Unable to download the activities")
        }
    }

    @MainActor func displayError(message: String) {
        errorMessage = message
        displayAlert = true
    }
}
