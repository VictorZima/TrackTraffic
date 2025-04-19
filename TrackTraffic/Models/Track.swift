//
//  Track.swift
//  TrackTraffic
//
//  Created by VictorZima on 26/04/2024.
//

import SwiftData

@Model
class Track {
    var number: String
    var model: String
    var driverName: String?
    var location: Location?
    
    init(number: String, model: String, driverName: String? = nil, location: Location? = nil) {
        self.number = number
        self.model = model
        self.driverName = driverName
        self.location = location
        
    }
}
