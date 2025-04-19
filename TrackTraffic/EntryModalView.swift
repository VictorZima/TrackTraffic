//
//  EntryModalView.swift
//  TrackTraffic
//
//  Created by VictorZima on 15/04/2025.
//

import SwiftUI
import Combine

struct EntryModalView: View {
    @Binding var trackNumber: String
    @Binding var driverName: String
    @Binding var selectedInTime: Date
    @Binding var selectedLocation: Location?
    
    var availableLocations: [Location]
    var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    var trackInAction: () -> Void
    var trackOutAction: () -> Void
    
    var body: some View {
        VStack(spacing: 6) {
            HStack {
                Spacer()
                Button {
                    trackNumber = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
            
            HStack {
                TextField("Enter number or chose from list", text: $trackNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 3)
                    .overlay(
                        HStack {
                            Spacer()
                            if !trackNumber.isEmpty {
                                Button {
                                    self.trackNumber = ""
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.black)
                                }
                                .padding(.trailing, 17)
                            }
                        }
                    )
                
                TextField("Enter name or chose from list", text: $driverName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 3)
                    .overlay(
                        HStack {
                            Spacer()
                            if !driverName.isEmpty {
                                Button {
                                    self.driverName = ""
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.black)
                                }
                                .padding(.trailing, 17)
                            }
                        }
                    )
            }
            
            Picker("Select Location", selection: $selectedLocation) {
                Text("None").tag(nil as Location?)
                ForEach(availableLocations, id: \.self) { location in
                    Text(location.name)
                        .tag(location as Location?)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal)
            
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
                    trackInAction()
                } label: {
                   Text("Entry")
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
                    trackOutAction()
                } label: {
                    Text("Exit")
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
        }
        .padding()
    }
}
