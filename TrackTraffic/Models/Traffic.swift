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
    var driverNameIn: String?
    var driverNameOut: String?
    var dateIn: Date?
    var dateOut: Date?
    var location: Location?
    
    init(trackNumber: String, driverNameIn: String? = nil, driverNameOut: String? = nil, dateIn: Date? = nil, dateOut: Date? = nil, location: Location? = nil) {
        self.trackNumber = trackNumber
        self.driverNameIn = driverNameIn
        self.driverNameOut = driverNameOut
        self.dateIn = dateIn
        self.dateOut = dateOut
        self.location = location
    }
}
