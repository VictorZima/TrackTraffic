//
//  AllTrafficView.swift
//  TrackTraffic
//
//  Created by VictorZima on 30/04/2024.
//

import SwiftUI
import SwiftData
import Combine

struct AllTrafficView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var traffics: [Traffic]
    
    @StateObject var viewModel = AllTrafficViewModel()
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("All Traffic")
                        .fontWeight(.bold)
                    Text(Date().formatted(.dateTime.day().month().year()))
                        .font(.subheadline)
                }
                Spacer()
                Button {
                    viewModel.printDocument()
                } label: {
                    Image(systemName: "printer")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            .padding(.horizontal, 10)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Car N")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Entry")
                        .font(.subheadline)
                        .frame(minWidth: 50, alignment: .center)
                    Text("Exit")
                        .font(.subheadline)
                        .frame(minWidth: 50, alignment: .center)
                    Text("Location")
                        .font(.subheadline)
                        .frame(minWidth: 50, alignment: .center)
                }
                .padding(.horizontal, 4)
                .background(Color.blue.opacity(0.3))
                .foregroundColor(.white)
                
                List {
                    ForEach(Array(viewModel.todaysTraffics.enumerated()), id: \.element.id) { index, traffic in
                        HStack {
                            Text(formatTrackNumber(traffic.trackNumber))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            VStack(alignment: .center) {
                                Text(traffic.dateIn?.formatted(.dateTime.hour().minute()) ?? "***")
                                    .frame(minWidth: 50, alignment: .center)
                                Text(traffic.driverNameIn ?? "n/a")
                                    .font(.caption)
                                    .padding(.horizontal, 6)
                            }
                            VStack(alignment: .center) {
                                Text(traffic.dateOut?.formatted(.dateTime.hour().minute()) ?? "***")
                                    .frame(minWidth: 50, alignment: .center)
                                Text(traffic.driverNameIn ?? "n/a")
                                    .font(.caption)
                                    .padding(.horizontal, 6)
                            }
                            Text(traffic.location?.name ?? "---")
                                .font(.caption)
                                .padding(.horizontal, 6)
                                .frame(maxWidth: .infinity)
                        }
                        .frame(maxHeight: .infinity, alignment: .leading)
                        .listRowInsets(EdgeInsets())
                        .background(index % 2 == 0 ? Color.gray.opacity(0.3) : Color.green.opacity(0.3))
                    }
                    .onDelete { offsets in
                        viewModel.deleteTraffic(at: offsets, in: modelContext)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.gray.opacity(0.2))

                }
                .listStyle(.plain)
                .onAppear { viewModel.updateTraffics(traffics) }
                .onChange(of: traffics) { oldValue, newValue in
                    viewModel.updateTraffics(newValue)
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
    
    
}
