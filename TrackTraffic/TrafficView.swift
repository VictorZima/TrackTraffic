//
//  TrafficView.swift
//  TrackTraffic
//
//  Created by VictorZima on 25/04/2024.
//

import SwiftUI
import SwiftData

struct TrafficView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = [Traffic]()
    @Query var people: [Person]
    @Query var traffics: [Traffic]
    @Query var tracks: [Track]
    @Query var locations: [Location]
    @State private var trackNumber: String = ""
    @State private var driverName: String = ""
    @State private var selectedInTime = Date()
    @State private var editMode: EditMode = .inactive
    @State private var selectedLocation: Location? = nil
    
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
                                    if let driver = track.driverName {
                                        driverName = driver
                                    }
                                    trackNumber = track.number
                                } label: {
                                    Text(formatTrackNumber(track.number))
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
                                    driverName = person.name
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
            
            if !trackNumber.isEmpty {
                VStack {
                    Spacer()
                    EntryModalView(trackNumber: $trackNumber,
                                   driverName: $driverName,
                                   selectedInTime: $selectedInTime,
                                   selectedLocation: $selectedLocation,
                                   availableLocations: locations,
                                   timer: timer,
                                   trackInAction: {
                        trackIn(trackNumber: trackNumber,
                                driverName: driverName,
                                dateIn: selectedInTime,
                                location: selectedLocation)
                    },
                                   trackOutAction: {
                        trackOut(trackNumber: trackNumber,
                                 driverName: driverName,
                                 dateOut: selectedInTime)
                    })
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .padding(.bottom, 40)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: trackNumber)
                }
            }
        }
    }
    
    func formatTrackNumber(_ number: String) -> String {
        let formattedNumber: String
        
        if number.count == 7 {
            let prefix = number.prefix(2)
            let middle = number.dropFirst(2).prefix(3)
            let suffix = number.suffix(2)
            formattedNumber = "\(prefix)-\(middle)-\(suffix)"
        } else if number.count == 8 {
            let prefix = number.prefix(3)
            let middle = number.dropFirst(3).prefix(2)
            let suffix = number.suffix(3)
            formattedNumber = "\(prefix)-\(middle)-\(suffix)"
            
        } else {
            formattedNumber = number
        }
        return formattedNumber
    }
    
    func trackIn(trackNumber: String, driverName: String, dateIn: Date, location: Location?) {
        let traffic = Traffic(trackNumber: trackNumber,
                              driverNameIn: driverName,
                              dateIn: dateIn,
                              location: location)
        modelContext.insert(traffic)
        clearForm()
    }
    
    func trackOut(trackNumber: String, driverName: String, dateOut: Date) {
        if let index = traffics.firstIndex(where: { $0.trackNumber == trackNumber && $0.dateOut == nil && Calendar.current.isDateInToday($0.dateIn ?? Date.distantPast) }) {
            traffics[index].dateOut = dateOut
            //modelContex.update(traffics[index])
            do {
                try modelContext.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        } else {
            let newTraffic = Traffic(trackNumber: trackNumber,
                                     driverNameOut: driverName,
                                     dateIn: nil,
                                     dateOut: dateOut)
            modelContext.insert(newTraffic)
        }
        clearForm()
    }
    
    func clearForm() {
        trackNumber = ""
        driverName = ""
    }
}

#Preview {
    TrafficView()
}

