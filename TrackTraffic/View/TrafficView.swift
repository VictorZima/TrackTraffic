//
//  TrafficView.swift
//  TrackTraffic
//
//  Created by VictorZima on 25/04/2024.
//

import SwiftUI
import SwiftData

struct TrafficView: View {
    @StateObject private var viewModel = TrafficViewModel()
    @Environment(\.modelContext) private var modelContext
    @State private var path = [Traffic]()
    
    @Query var people: [Person]
    @Query var traffics: [Traffic]
    @Query var tracks: [Track]
    @Query var locations: [Location]
    
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    Text("Choice track number")
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                    
                    HStack(alignment: .top) {
                        VStack {
                            ForEach(tracks, id: \.self) { track in
                                Button {
                                    viewModel.driverName = track.driverName ?? ""
                                    viewModel.selectedLocation = track.location
                                    viewModel.selectedInTime = Date()
                                    withAnimation {
                                        viewModel.trackNumber = track.number
                                    }
                                } label: {
                                    Text(viewModel.formatTrackNumber(track.number))
                                }
                                .frame(width: 100)
                                .padding(.vertical, 7)
                                .background(.black)
                                .foregroundColor(.white)
                                .font(.headline)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .shadow(radius: 5)
                            }
                        }
                        
                        VStack {
                            ForEach(people) { person in
                                Button {
                                    viewModel.driverName = person.name
                                } label: {
                                    Text(person.name)
                                        .frame(width: 120)
                                        .padding(.vertical, 7)
                                        .background(.black)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                        .shadow(radius: 5)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            
            if viewModel.isModalPresented {
                VStack {
                    Spacer()
                    EntryModalView(trackNumber: $viewModel.trackNumber,
                                   driverName: $viewModel.driverName,
                                   selectedInTime: $viewModel.selectedInTime,
                                   selectedLocation: $viewModel.selectedLocation,
                                   availableLocations: locations,
                                   timer: timer,
                                   trackInAction:     { viewModel.trackIn(context: modelContext) },
                                   trackOutAction:    { viewModel.trackOut(context: modelContext, allTraffics: traffics) }
                    )
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .padding(.bottom, 40)
                    .transition(.move(edge: .bottom))
                }
            }
        }
    }
}

#Preview {
    TrafficView()
}

