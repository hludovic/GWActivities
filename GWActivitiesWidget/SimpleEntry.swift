//
//  SimpleEntry.swift
//  GWActivitiesWidgetExtension
//
//  Created by Ludovic HENRY on 21/06/2023.
//

import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
    let lastestActivities: Scraper.LastestActivities
}
