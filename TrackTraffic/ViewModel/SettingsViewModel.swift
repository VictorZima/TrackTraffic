//
//  SettingsViewModel.swift
//  TrackTraffic
//
//  Created by VictorZima on 19/04/2025.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    @Published var isLocationPresented = false
    @Published var isTrackPresented    = false
    @Published var isPersonPresented   = false
    
    func showLocation() { isLocationPresented = true }
    func showTrack()    { isTrackPresented    = true }
    func showPerson()   { isPersonPresented   = true }
}
