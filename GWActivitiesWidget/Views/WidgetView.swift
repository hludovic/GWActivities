//
//  WidgetView.swift
//  GWActivitiesWidgetExtension
//
//  Created by Ludovic HENRY on 21/06/2023.
//

import WidgetKit
import SwiftUI

struct WidgetView: View {
    var entry: SimpleEntry
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        LargeSizeView(dayActivity: entry.lastestActivities.dayActivity, weekActivity: entry.lastestActivities.weekActivity)
    }
}
