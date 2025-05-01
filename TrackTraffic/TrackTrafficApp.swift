//
//  TrackTrafficApp.swift
//  TrackTraffic
//
//  Created by VictorZima on 23/04/2024.
//

import SwiftUI

@main
struct TrackTrafficApp: App {
    @AppStorage("selectedLanguage") private var selectedLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, Locale(identifier: selectedLanguage))
                .environment(\.layoutDirection, selectedLanguage == "he" ? .rightToLeft : .leftToRight)
        }
        .modelContainer(for: [Person.self, Traffic.self, Track.self, Location.self])
    }
}
