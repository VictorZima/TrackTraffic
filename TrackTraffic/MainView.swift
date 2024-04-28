//
//  MainView.swift
//  TrackTraffic
//
//  Created by VictorZima on 23/04/2024.
//

import SwiftUI
import SwiftData

struct MainView: View {
    var body: some View {
        TabView {
            TrafficView()
                .tabItem {
                    Label("Traffic", systemImage: "car.2")
                }
            PersonView()
                .tabItem {
                    Label("Drivers", systemImage: "figure.seated.seatbelt")
                }
            TrackView()
                .tabItem {
                    Label("Tracks", systemImage: "car.side")
                }
        }
    }
}

#Preview {
    MainView()
}
