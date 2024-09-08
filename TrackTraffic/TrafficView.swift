//
//  TrafficView.swift
//  TrackTraffic
//
//  Created by VictorZima on 25/04/2024.
//

import SwiftUI
import SwiftData

struct TrafficView: View {
    @Environment(\.modelContext) var modelContex
    @State private var path = [Traffic]()
    @Query var people: [Person]
    @Query var traffics: [Traffic]
    @Query var tracks: [Track]
    @State private var trackNumber: String = ""
    @State private var driverName: String = ""
    @State private var selectedInTime = Date()
    @State private var editMode: EditMode = .inactive
    
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.blue
                .opacity(0.1)
                .edgesIgnoringSafeArea(.top)
            
            Image("trafficBackground")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.1)
            
            VStack(spacing: 3) {
                Text("מעקב תנועה")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.orange)
                
                HStack(alignment: .top) {
                    VStack(spacing: 3) {
                        TextField("Enter number or chose from list", text: $trackNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom, 3)
                            .overlay(
                                HStack {
                                    Spacer()
                                    if !trackNumber.isEmpty {
                                        Button(action: {
                                            self.trackNumber = ""
                                        }) {
                                            Image(systemName: "multiply.circle.fill")
                                                .foregroundColor(.black)
                                        }
                                        .padding(.trailing, 17)
                                    }
                                }
                            )
                        
                        ForEach(tracks, id: \.self) { track in
                            Button {
                                if let driver = track.driverName {
                                    driverName = driver
                                }
                                trackNumber = track.number
                            } label: {
                                VStack {
                                    Text(formatTrackNumber(track.number))
                                }
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
                    VStack(spacing: 3) {
                        TextField("Enter name or chose from list", text: $driverName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom, 3)
                            .overlay(
                                HStack {
                                    Spacer()
                                    if !driverName.isEmpty {
                                        Button(action: {
                                            self.driverName = ""
                                        }) {
                                            Image(systemName: "multiply.circle.fill")
                                                .foregroundColor(.black)
                                        }
                                        .padding(.trailing, 17)
                                    }
                                }
                            )
                        
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
                .padding(.bottom, 5)
                
                DatePicker("Time", selection: $selectedInTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(CompactDatePickerStyle())
                    .labelsHidden()
                    .onReceive(timer) { input in
                        selectedInTime = input
                    }
                    .foregroundColor(.gray)
                    .background(Color.clear)
                
                HStack(spacing: 20) {
                    Button {
                        trackIn(trackNumber: trackNumber, driverName: driverName, dateIn: selectedInTime)
                    } label: {
                        Text("כניסה")
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(25)
                    }
                    .background(trackNumber.isEmpty ? .gray : .green)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .disabled(trackNumber.isEmpty)
                    
                    Button {
                        trackOut(trackNumber: trackNumber, driverName: driverName, dateOut: selectedInTime)
                    } label: {
                        Text("יציאה")
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(25)
                    }
                    .background(trackNumber.isEmpty ? .gray : .red)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .disabled(trackNumber.isEmpty)
                }
                .padding(.bottom, 30)
            }
            .padding()
        }
    }
    
    func trackIn(trackNumber: String, driverName: String, dateIn: Date) {
        let traffic = Traffic(trackNumber: trackNumber, driverName: driverName, dateIn: dateIn)
        modelContex.insert(traffic)
        clearForm()
    }
    
    func trackOut(trackNumber: String, driverName: String, dateOut: Date) {
        if let index = traffics.firstIndex(where: { $0.trackNumber == trackNumber && $0.dateOut == nil && Calendar.current.isDateInToday($0.dateIn ?? Date.distantPast) }) {
            traffics[index].dateOut = dateOut
            //modelContex.update(traffics[index])
            do {
                try modelContex.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        } else {
            let newTraffic = Traffic(trackNumber: trackNumber, driverName: driverName, dateIn: nil, dateOut: dateOut)
            modelContex.insert(newTraffic)
        }
        clearForm()
    }
    
    func clearForm() {
        trackNumber = ""
        driverName = ""
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
}

#Preview {
    TrafficView()
}
