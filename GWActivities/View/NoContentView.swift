//
//  NoContentView.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 12/06/2023.
//

import SwiftUI

struct NoContentView: View {
    @State var activity: Activity
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(.yellow)
            Text(activity.name)
            Text("No content loaded")
                .font(.title2)
            Text("Please refresh")
        }
    }
}

struct NoContentView_Previews: PreviewProvider {
    static var previews: some View {
        NoContentView(activity: .weekly)
            .padding()
    }
}
