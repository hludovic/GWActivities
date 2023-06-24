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
        SimpleEntry(
            date: .now,
            lastestActivities: Scraper.LastestActivities(
                DayActivity.fakeData[0],
                WeekActivity.fakeData[0]
            )
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        Task {
            do {
                let scraper = Scraper.shared
                let dayActivities = try await scraper.getActivities(DayActivity.self)
                let weekActivities = try await scraper.getActivities(WeekActivity.self)
                let lastestActivities = try scraper.getLastestActivities(dayActivities: dayActivities, weekActivities: weekActivities, for: .now)
                completion(SimpleEntry(date: .now, lastestActivities: lastestActivities))
            } catch {
                completion (
                    SimpleEntry(
                        date: .now,
                        lastestActivities: Scraper.LastestActivities(
                            DayActivity.fakeData[0],
                            WeekActivity.fakeData[0]
                        )
                    )
                )
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        Task {
            do {
                var entries: [SimpleEntry] = []
                // Generate a timeline consisting of five entries an hour apart, starting from the current date.
                let currentDate = Date()
                for dayOffset in 0 ..< 5 {
                    let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
                    let scraper = Scraper.shared
                    let dayActivities = try await scraper.getActivities(DayActivity.self)
                    let weekActivities = try await scraper.getActivities(WeekActivity.self)
                    let lastestActivities = try scraper.getLastestActivities(dayActivities: dayActivities, weekActivities: weekActivities, for: entryDate)

                    let entry = SimpleEntry(date: entryDate, lastestActivities: lastestActivities)
                    entries.append(entry)
                    let timeline = Timeline(entries: entries, policy: .atEnd)
                    completion(timeline)
                }
            } catch {
                let entries = [SimpleEntry(date: .now, lastestActivities: Scraper.LastestActivities(DayActivity.fakeData[0],WeekActivity.fakeData[0]))]
                let timeline = Timeline(entries: entries, policy: .atEnd)
                completion(timeline)
            }
        }
    }
}
