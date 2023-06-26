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
        return SimpleEntry(date: .now, lastestActivities: lastActivities, mode: .placeholder)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        Task {
            do {
                let scraper = Scraper.shared
                let dayActivities = try await scraper.getActivities(DayActivity.self)
                let weekActivities = try await scraper.getActivities(WeekActivity.self)
                let activities = Activities(dayActivities: dayActivities, weekActivities: weekActivities)
                let lastActivities = try scraper.getLastestActivities(activities: activities, for: .now)
                completion(SimpleEntry(date: .now, lastestActivities: lastActivities, mode: .loaded))
            } catch {
                let lastActivities = LastestActivities(DayActivity.fakeData[0], WeekActivity.fakeData[0])
                completion(SimpleEntry( date: .now, lastestActivities: lastActivities, mode: .failed))
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
                for dayOffset in 0 ..< 2 {
                    let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
                    let activities = Activities(dayActivities: dayActivities, weekActivities: weekActivities)
                    let lastActivities = try scraper.getLastestActivities(activities: activities, for: entryDate)
                    let entry = SimpleEntry(date: entryDate, lastestActivities: lastActivities, mode: .loaded)
                    entries.append(entry)
                }
                let timeline = Timeline(entries: entries, policy: .atEnd)
                completion(timeline)
            } catch {
                print(error.localizedDescription)
                let lastestActivities = LastestActivities(DayActivity.fakeData[0],WeekActivity.fakeData[0])
                let nextUpdate = Calendar.current.date(byAdding: .minute, value: 1, to: .now)!
                let entries = [SimpleEntry(date: .now, lastestActivities: lastestActivities, mode: .failed)]
                let timeline = Timeline(entries: entries, policy: .after(nextUpdate))
                completion(timeline)
            }
        }
    }
}
