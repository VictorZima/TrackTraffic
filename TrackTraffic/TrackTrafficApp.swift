//
//  TrackTrafficApp.swift
//  TrackTraffic
//
//  Created by VictorZima on 23/04/2024.
//

import SwiftUI

@main
struct TrackTrafficApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: [Person.self, Traffic.self, Track.self])
    }
}
