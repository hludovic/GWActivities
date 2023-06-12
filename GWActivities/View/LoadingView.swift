//
//  LoadingView.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 12/06/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack{
            ProgressView()
            Text("Loading ...")
                .padding(.top, 5)
                .font(.title2)
                .foregroundColor(.secondary)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .padding()
    }
}
