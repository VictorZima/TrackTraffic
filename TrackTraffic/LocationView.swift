//
//  LocationView.swift
//  TrackTraffic
//
//  Created by VictorZima on 15/04/2025.
//

import SwiftUI
import SwiftData

struct LocationView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = [Location]()
    @Query var location: [Location]
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(location) { location in
                    NavigationLink(value: location) {
                        Text(location.name)
                    }
                }
                .onDelete(perform: deleteLocation)
            }
            .navigationTitle("Locations")
            .navigationDestination(for: Location.self) { location in
                EditLocationView(location: location)
            }
            .toolbar {
                Button("Add Location", systemImage: "plus", action: addLocation)
            }
        }
        
    }
    
    func addLocation() {
        let location = Location(name: "")
        modelContext.insert(location)
        path.append(location)
    }
    
    func deleteLocation(at offsets: IndexSet) {
        for offset in offsets {
            let location = location[offset]
            modelContext.delete(location)
        }
    }
}
