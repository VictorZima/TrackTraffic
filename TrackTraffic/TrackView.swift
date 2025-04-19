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
    @State private var path = [Track]()
    @Query var track: [Track]
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(track) { track in
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
                .onDelete(perform: deleteTrack)
            }
            .navigationTitle("Tracks")
            .navigationDestination(for: Track.self) { track in
                EditTrackView(track: track)
            }
            .toolbar {
                Button("Add Track", systemImage: "plus", action: addTrack)
            }
        }
    }
    
    func addTrack() {
        let track = Track(number: "", model: "", driverName: nil)
        modelContext.insert(track)
        path.append(track)
    }
    
    func deleteTrack(at offsets: IndexSet) {
        for offset in offsets {
            let track = track[offset]
            modelContext.delete(track)
        }
    }
}

#Preview {
    TrackView()
}
