//
//  TrackView.swift
//  TrackTraffic
//
//  Created by VictorZima on 26/04/2024.
//

import SwiftUI
import SwiftData

struct TrackView: View {
    @Environment(\.modelContext) var modelContext
    @StateObject private var viewModel = TrackViewModel()
    @Query var tracks: [Track]
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            List {
                ForEach(tracks) { track in
                    NavigationLink(value: track) {
                        HStack {
                            VStack {
                                Text(track.number)
                                if let driverName = track.driverName {
                                    Text(driverName)
                                        .font(.caption)
                                        .foregroundStyle(Color.gray)
                                } else {
                                    Text("---")
                                        .font(.caption)
                                        .foregroundStyle(Color.gray)
                                }
                                
                                if let locationName = track.location?.name {
                                    Text(locationName)
                                        .font(.caption)
                                        .foregroundStyle(Color.gray)
                                } else {
                                    Text("---")
                                        .font(.caption)
                                        .foregroundStyle(Color.gray)
                                }
                            }
                            Spacer()
                            Text(track.model)
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete { viewModel.deleteTrack(at: $0, from: tracks, modelContext: modelContext) }
            }
            .navigationTitle("Tracks")
            .navigationDestination(for: Track.self) { track in
                EditTrackView(track: track)
            }
            .toolbar {
                Button("Add Track", systemImage: "plus") {
                    viewModel.addTrack(modelContext: modelContext)
                }
            }
        }
    }
}

#Preview {
    TrackView()
}
