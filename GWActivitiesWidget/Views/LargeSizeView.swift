//
//  LargeSizeView.swift
//  GWActivitiesWidgetExtension
//
//  Created by Ludovic HENRY on 23/06/2023.
//

import WidgetKit
import SwiftUI

struct LargeSizeView: View {
    let dayActivity: DayActivity
    let weekActivity: WeekActivity

    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(Color("colorbg"))
            VStack(alignment: .leading) {
                ZStack{
                    Rectangle()
                        .fill(Color("color1"))
                        .frame(width: .infinity, height: 40)
                    HStack {
                        Spacer()
                        Text("Latest in-game activities")
                            .font(.title2.bold())
                            .foregroundColor(Color("color3"))
                        Spacer()
                        Image("gwIcon")
                            .resizable()
                            .frame(width: 90, height: 90)
                    }
                }
                Group {
                    TodayTextView(dayActivity: dayActivity)
                    ThisWeekTextView(weekActivity: weekActivity)
                    ThisMonthTextView()
                }
                .offset(x: 0, y: -20)
                .padding(.leading, 7)
                .lineLimit(1)
                .font(.title3)
                Spacer()
            }
        }
    }
}

struct LargeSizeView_Previews: PreviewProvider {
    static var previews: some View {
        let dayActivity = DayActivity.fakeData.first!
        let weekActivity = WeekActivity.fakeData.first!
        LargeSizeView(dayActivity: dayActivity, weekActivity: weekActivity)
    }
}
