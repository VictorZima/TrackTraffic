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
    @State private var selectedFilterLocation: Location? = nil
    @State private var isModalVisible = false
    
    @Query var people: [Person]
    @Query var traffics: [Traffic]
    @Query var tracks: [Track]
    @Query var locations: [Location]
    
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Choice track number")
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        Button(action: { selectedFilterLocation = nil }) {
                            Text("All")
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                                .background(selectedFilterLocation == nil ? Color.blue : Color.clear)
                                .foregroundColor(selectedFilterLocation == nil ? .white : .primary)
                                .cornerRadius(8)
                        }

                        ForEach(locations, id: \.self) { loc in
                            let isSelected = selectedFilterLocation?.id == loc.id
                            Button(action: {
                                selectedFilterLocation = isSelected ? nil : loc
                            }) {
                                Text(loc.name)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 12)
                                    .background(isSelected ? Color.blue : Color.clear)
                                    .foregroundColor(isSelected ? .white : .primary)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                
                ScrollView {
                    HStack(alignment: .top) {
                        VStack {
                            ForEach(tracks.filter { selectedFilterLocation == nil || $0.location?.id == selectedFilterLocation?.id }, id: \.self) { track in
                                Button {
                                    viewModel.driverName = track.driverName ?? ""
                                    viewModel.selectedLocation = track.location
                                    viewModel.selectedInTime = Date()
                                    withAnimation {
                                        viewModel.trackNumber = track.number
                                        isModalVisible = true
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
                            ForEach(people.filter { selectedFilterLocation == nil || $0.location?.id == selectedFilterLocation?.id }, id: \.self) { person in
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
                    .padding(.bottom, 20)
                }
                .padding(.bottom, viewModel.isModalVisible ? 280 : 0)
            }
            
            if isModalVisible {
                VStack {
                    Spacer()
                    EntryModalView(trackNumber: $viewModel.trackNumber,
                                   driverName: $viewModel.driverName,
                                   selectedInTime: $viewModel.selectedInTime,
                                   selectedLocation: $viewModel.selectedLocation,
                                   availableLocations: locations,
                                   timer: timer,
                                   trackInAction:     { viewModel.trackIn(context: modelContext) },
                                   trackOutAction:    { viewModel.trackOut(context: modelContext, allTraffics: traffics) },
                                   closeAction:       { isModalVisible = false }
                    )
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .transition(.move(edge: .bottom))
                }
            }
        }
    }
}

#Preview {
    TrafficView()
}

