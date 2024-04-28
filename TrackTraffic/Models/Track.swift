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
    
    init(number: String, model: String) {
        self.number = number
        self.model = model
    }
}
