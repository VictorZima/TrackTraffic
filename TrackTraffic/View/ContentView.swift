//
//  ContentView.swift
//  TrackTraffic
//
//  Created by VictorZima on 23/04/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(value: 0) {
                TrafficView()
            }
            Tab(value: 1) {
                AllTrafficView()
            }
            Tab(value: 2) {
                SettingsView()
            }
        }
        .overlay(alignment: .bottom) {
            BottomTabBarView(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    ContentView()
}
