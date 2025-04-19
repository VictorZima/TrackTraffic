//
//  Location.swift
//  TrackTraffic
//
//  Created by VictorZima on 11/04/2025.
//

import SwiftData

@Model
class Location {
    var name: String
    
    @Relationship(inverse: \Track.location)
    var tracks: [Track] = []
    
    init(name: String, tracks: [Track] = []) {
        self.name = name
        self.tracks = tracks
    }
}
