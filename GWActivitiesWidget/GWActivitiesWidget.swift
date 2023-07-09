//
//  GWActivitiesWidget.swift
//  GWActivitiesWidget
//
//  Created by Ludovic HENRY on 21/06/2023.
//

import WidgetKit
import SwiftUI

@main
struct GWActivitiesWidget: Widget {
    let kind: String = "GWActivitiesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetView(entry: entry)
        }
        .supportedFamilies([.systemLarge])
        .configurationDisplayName("Latest Activities")
        .description("View the lastest Guild Wars activities.")
    }
}

struct GWActivitiesWidget_Previews: PreviewProvider {
    static var previews: some View {
        let dayActivity = DayActivity.placeholder
        let weekActivity = WeekActivity.placeholder
        let lastestActivities = LastestActivities(dayActivity, weekActivity)
        WidgetView(entry: SimpleEntry(date: Date(), lastestActivities: lastestActivities, mode: .loaded))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
