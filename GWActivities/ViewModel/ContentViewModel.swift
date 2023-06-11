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
    @Published var lineSelected: DayActivity.ID? = nil
    @Published var searchable: String = ""
    @Published var selectedActivity: Activities = .daily
    @Published var errorMessage: String = ""
    @Published var displayAlert: Bool = false
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: ContentViewModel.self))

    func downloadDailyActivities() async {
        logger.info("Started downloading daily activities - Task \(self.taskID)")
        do {
            let requestResult: [DayActivity] = try await Scraper.getDailyActivities()
            await MainActor.run {
                logger.info("Finished downloading daily activities - Task \(self.taskID)")
                dayActivities = requestResult
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
            return await displayError(message: "Unable to download the activities")
        }
    }

    @MainActor func displayError(message: String) {
        errorMessage = message
        displayAlert = true
    }
}
