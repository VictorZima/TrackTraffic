//
//  Traffic.swift
//  Traffic
//
//  Created by VictorZima on 25/04/2024.
//

import Foundation
import SwiftData

@Model
class Traffic {
    var trackNumber: String
    var driverName: String?
    var dateIn: Date?
    var dateOut: Date?
    var location: Location?
    
    init(trackNumber: String, driverName: String? = nil, dateIn: Date? = nil, dateOut: Date? = nil, location: Location? = nil) {
        self.trackNumber = trackNumber
        self.driverName = driverName
        self.dateIn = dateIn
        self.dateOut = dateOut
        self.location = location
    }
}
