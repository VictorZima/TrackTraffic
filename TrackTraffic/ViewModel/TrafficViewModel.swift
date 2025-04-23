//
//  TrafficViewModel.swift
//  TrackTraffic
//
//  Created by VictorZima on 19/04/2025.
//

import Foundation
import SwiftData

final class TrafficViewModel: ObservableObject {
    @Published var trackNumber: String = ""
    @Published var driverName: String = ""
    @Published var selectedInTime: Date = Date()
    @Published var selectedLocation: Location? = nil
    
    var isModalPresented: Bool { !trackNumber.isEmpty }
    
    func formatTrackNumber(_ number: String) -> String {
        if number.count == 7 {
            let prefix = number.prefix(2)
            let middle = number.dropFirst(2).prefix(3)
            let suffix = number.suffix(2)
            return "\(prefix)-\(middle)-\(suffix)"
        } else if number.count == 8 {
            let prefix = number.prefix(3)
            let middle = number.dropFirst(3).prefix(2)
            let suffix = number.suffix(3)
            return "\(prefix)-\(middle)-\(suffix)"
            
        }
        return number
    }
    
    func trackIn(context: ModelContext) {
        let traffic = Traffic(trackNumber: trackNumber,
                              driverNameIn: driverName,
                              dateIn: selectedInTime,
                              location: selectedLocation)
        context.insert(traffic)
        clearForm()
    }
    
    func trackOut(context: ModelContext, allTraffics: [Traffic]) {
        if let idx = allTraffics.firstIndex(where: {
            $0.trackNumber == trackNumber &&
            $0.dateOut == nil &&
            Calendar.current.isDateInToday($0.dateIn ?? .distantPast)
        }) {
            allTraffics[idx].driverNameOut = driverName.isEmpty ? nil : driverName
            allTraffics[idx].dateOut = selectedInTime
            try? context.save()
        } else {
            let traffic = Traffic(
                trackNumber: trackNumber,
                driverNameOut: driverName.isEmpty ? nil : driverName,
                dateIn: nil,
                dateOut: selectedInTime,
                location: selectedLocation
            )
            context.insert(traffic)
        }
        clearForm()
    }
    
    func clearForm() {
        trackNumber = ""
        driverName = ""
        selectedInTime = Date()
        selectedLocation = nil
    }
    
}
