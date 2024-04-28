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
                            Text(track.number)
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
        let track = Track(number: "", model: "")
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
