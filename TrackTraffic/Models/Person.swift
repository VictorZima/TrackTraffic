//
//  Person.swift
//  TrackTraffic
//
//  Created by VictorZima on 23/04/2024.
//

import SwiftData

@Model
class Person {
    var name: String
    var location: Location?
    
    init(name: String, location: Location? = nil) {
        self.name = name
        self.location = location
    }
}
