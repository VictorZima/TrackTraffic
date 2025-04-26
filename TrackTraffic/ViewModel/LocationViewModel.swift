//
//  LocationViewModel.swift
//  TrackTraffic
//
//  Created by VictorZima on 26/04/2025.
//

import Foundation
import SwiftData

final class LocationViewModel: ObservableObject {
    @Published var path = [Location]()
    
    func addLocation(context: ModelContext) {
        let newLocation = Location(name: "")
        context.insert(newLocation)
        path.append(newLocation)
    }
    
    func deleteLocation(at offsets: IndexSet, from locations: [Location], modelContext: ModelContext) {
        for offset in offsets {
            let locationToDelete = locations[offset]
            modelContext.delete(locationToDelete)
        }
    }
}
