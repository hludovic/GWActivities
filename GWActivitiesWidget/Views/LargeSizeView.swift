//
//  LargeSizeView.swift
//  GWActivitiesWidgetExtension
//
//  Created by Ludovic HENRY on 23/06/2023.
//

import WidgetKit
import SwiftUI

struct LargeSizeView: View {
    enum Mode { case loaded, placeholder, failed }
    let dayActivity: DayActivity
    let weekActivity: WeekActivity
    let mode: Mode
    private var placeholder : Bool {
        return mode == .placeholder ? true : false
    }
    private var failed: Bool {
        return mode == .failed ? true : false
    }

    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(Color("colorbg"))
            VStack(alignment: .leading) {
                ZStack{
                    Rectangle()
                        .fill(Color("color1"))
                        .frame(height: 40)
                    HStack {
                        Spacer()
                        Text("Latest in-game activities")
                            .font(.title2.bold())
                            .foregroundColor(Color("color3"))
                            .redacted(reason: placeholder ? .placeholder : [])
                        Spacer()
                        Image("gwIcon")
                            .resizable()
                            .frame(width: 90, height: 90)
                    }
                }
                if failed {
                    Spacer()
                    HStack{
                        Spacer()
                        Text("Data not Loaded")
                            .font(.title3)
                        Spacer()
                    }
                } else {
                    Group {
                        TodayTextView(dayActivity: dayActivity)
                            .redacted(reason: placeholder ? .placeholder : [])
                        ThisWeekTextView(weekActivity: weekActivity)
                            .redacted(reason: placeholder ? .placeholder : [])
                        ThisMonthTextView()
                            .redacted(reason: placeholder ? .placeholder : [])
                    }
                    .offset(x: 0, y: -20)
                    .padding(.leading, 7)
                    .lineLimit(1)
                    .font(.title3)
                }
                Spacer()
            }
        }
    }
}

struct LargeSizeView_Previews: PreviewProvider {
    static var previews: some View {
        let dayActivity = DayActivity.placeholder
        let weekActivity = WeekActivity.placeholder
        LargeSizeView(dayActivity: dayActivity, weekActivity: weekActivity, mode: .loaded)
    }
}
