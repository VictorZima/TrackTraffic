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
    @StateObject private var viewModel = LocationViewModel()
    @Query var locations: [Location]
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            List {
                ForEach(locations) { location in
                    NavigationLink(value: location) {
                        Text(location.name)
                    }
                }
                .onDelete {
                    viewModel.deleteLocation(at: $0, from: locations, modelContext: modelContext)
                }
            }
            .navigationTitle("Locations")
            .navigationDestination(for: Location.self) { location in
                EditLocationView(location: location)
            }
            .toolbar {
                Button {
                    viewModel.addLocation(context: modelContext)
                } label: {
                    Label("Add Location", systemImage: "plus")
                }
            }
        }
        
    }
}
