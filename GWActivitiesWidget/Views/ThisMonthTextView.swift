//
//  ThisMonthTextView.swift
//  GWActivitiesWidgetExtension
//
//  Created by Ludovic HENRY on 24/06/2023.
//

import SwiftUI

struct ThisMonthTextView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("This month:")
                .foregroundColor(Color("color2"))
                .font(.title2)
                .bold()
            Group {
                HStack(spacing: 3) {
                    Text("Flux:")
                        .bold()
                    Text("Not implemented...")
                }
            }
        }
        .font(.body)
        .padding(.leading, 7)
        .lineLimit(1)
        .foregroundColor(Color("color1"))
    }
}

struct ThisMonthTextView_Previews: PreviewProvider {
    static var previews: some View {
        ThisMonthTextView()
    }
}
