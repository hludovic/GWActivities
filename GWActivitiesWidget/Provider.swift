//
//  Provider.swift
//  GWActivitiesWidgetExtension
//
//  Created by Ludovic HENRY on 21/06/2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        let lastActivities = LastestActivities(DayActivity.fakeData[0], WeekActivity.fakeData[0])
        return SimpleEntry(date: .now, lastestActivities: lastActivities)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        Task {
            do {
                let scraper = Scraper.shared
                let dayActivities = try await scraper.getActivities(DayActivity.self)
                let weekActivities = try await scraper.getActivities(WeekActivity.self)
                let activities = Activities(dayActivities: dayActivities, weekActivities: weekActivities)
                let lastActivities = try scraper.getLastestActivities(activities: activities, for: .now)
                completion(SimpleEntry(date: .now, lastestActivities: lastActivities))
            } catch {
                let lastActivities = LastestActivities(DayActivity.fakeData[0], WeekActivity.fakeData[0])
                completion(SimpleEntry( date: .now, lastestActivities: lastActivities))
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        Task {
            do {
                var entries: [SimpleEntry] = []
                let scraper = Scraper.shared
                let dayActivities = try await scraper.getActivities(DayActivity.self)
                let weekActivities = try await scraper.getActivities(WeekActivity.self)
                let currentDate = Date()
                for dayOffset in 0 ..< 5 {
                    let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
                    let activities = Activities(dayActivities: dayActivities, weekActivities: weekActivities)
                    let lastActivities = try scraper.getLastestActivities(activities: activities, for: entryDate)
                    let entry = SimpleEntry(date: entryDate, lastestActivities: lastActivities)
                    entries.append(entry)
                    let timeline = Timeline(entries: entries, policy: .atEnd)
                    completion(timeline)
                }
            } catch {
                let lastestActivities = LastestActivities(DayActivity.fakeData[0],WeekActivity.fakeData[0])
                let entries = [SimpleEntry(date: .now, lastestActivities: lastestActivities)]
                let timeline = Timeline(entries: entries, policy: .atEnd)
                completion(timeline)
            }
        }
    }
}
