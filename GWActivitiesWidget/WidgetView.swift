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

    var body: some View {
        Text(entry.date, style: .time)
    }
}
