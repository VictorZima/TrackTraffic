//
//  TrackViewModel.swift
//  TrackTraffic
//
//  Created by VictorZima on 26/04/2025.
//

import Foundation
import SwiftData

final class TrackViewModel: ObservableObject {
    @Published var path = [Track]()
    
    func addTrack(modelContext: ModelContext) {
        let newTrack = Track(number: "", model: "", driverName: nil)
        modelContext.insert(newTrack)
        path.append(newTrack)
    }
    
    func deleteTrack(at offsets: IndexSet, from tracks: [Track], modelContext: ModelContext) {
        for offset in offsets {
            let trackToDelete = tracks[offset]
            modelContext.delete(trackToDelete)
        }
    }
}
