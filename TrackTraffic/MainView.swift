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
                    Label("כניסה/יציאה", systemImage: "car.2")
                }
            AllTrafficView()
                .tabItem {
                    Label("כל התנועה", systemImage: "parkingsign.radiowaves.right.and.safetycone")
                }
            PersonView()
                .tabItem {
                    Label("נהגים", systemImage: "figure.seated.seatbelt")
                }
            TrackView()
                .tabItem {
                    Label("משאיות", systemImage: "truck.box")
                }
        }
        .tint(.black)
        .onAppear(perform: {
            UITabBar.appearance().unselectedItemTintColor = .gray
            UITabBar.appearance().backgroundColor = .systemGray6
        })
    }
}

#Preview {
    MainView()
}
