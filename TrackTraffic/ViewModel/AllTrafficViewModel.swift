//
//  AllTrafficViewModel.swift
//  TrackTraffic
//
//  Created by VictorZima on 19/04/2025.
//

import Foundation
import SwiftUI
import SwiftData

class AllTrafficViewModel: ObservableObject {
    @Published var selectedFilterLocation: Location? = nil
    @Published var traffics: [Traffic] = []
    @Published var locations: [Location] = []

    var todaysTraffics: [Traffic] {
        traffics.filter { traffic in
            guard let dateIn = traffic.dateIn else { return false }
            return Calendar.current.isDateInToday(dateIn)
        }
    }

    var filteredTraffics: [Traffic] {
        todaysTraffics.filter {
            selectedFilterLocation == nil || $0.location?.id == selectedFilterLocation?.id
        }
    }

    func updateData(traffics: [Traffic], locations: [Location]) {
        self.traffics = traffics
        self.locations = locations
    }

    func deleteTraffic(at offsets: IndexSet, in context: ModelContext) {
        let itemsToDelete = offsets.map { filteredTraffics[$0] }
        for traffic in itemsToDelete {
            context.delete(traffic)
        }
        try? context.save()
    }

    func printDocument() {
        // existing implementation moved here
    }

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
        } else {
            return number
        }
    }
}
