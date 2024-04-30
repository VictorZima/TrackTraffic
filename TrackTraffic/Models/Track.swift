//
//  Track.swift
//  TrackTraffic
//
//  Created by VictorZima on 26/04/2024.
//

import Foundation
import SwiftData

@Model
class Track {
    var number: String
    var model: String
    var driverName: String?
    
    init(number: String, model: String, driverName: String? = nil) {
        self.number = number
        self.model = model
        self.driverName = driverName
    }
}
