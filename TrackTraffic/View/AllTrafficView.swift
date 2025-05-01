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
//    @Environment(\.layoutDirection) private var layoutDirection
    @Environment(\.modelContext) private var modelContext
    @Query var traffics: [Traffic]
    @Query var locations: [Location]
    @State private var selectedFilterLocation: Location? = nil
    @StateObject var viewModel = AllTrafficViewModel()
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(LocalizedStringKey("allTraffic.title"))
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
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    Button(action: { selectedFilterLocation = nil }) {
                        Text("All")
                            .padding(.vertical, 6).padding(.horizontal, 12)
                            .background(selectedFilterLocation == nil ? Color.blue : Color.clear)
                            .foregroundColor(selectedFilterLocation == nil ? .white : .primary)
                            .cornerRadius(8)
                    }
                    ForEach(locations, id: \.self) { loc in
                        let isSel = selectedFilterLocation?.id == loc.id
                        Button(action: { selectedFilterLocation = isSel ? nil : loc }) {
                            Text(loc.name)
                                .padding(.vertical, 6).padding(.horizontal, 12)
                                .background(isSel ? Color.blue : Color.clear)
                                .foregroundColor(isSel ? .white : .primary)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    VStack {
                        Text("car.number")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                    }
                    Text("entry.button")
                        .font(.subheadline)
                        .frame(width: 80, alignment: .center)
                    Text("exit.button")
                        .font(.subheadline)
                        .frame(width: 80, alignment: .center)
                }
                .background(Color.blue.opacity(0.3))
                .foregroundColor(.white)

                List {
                    ForEach(Array(
                        viewModel.todaysTraffics
                            .filter { selectedFilterLocation == nil || $0.location?.id == selectedFilterLocation?.id }
                            .enumerated()
                    ), id: \.element.id) { index, traffic in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(formatTrackNumber(traffic.trackNumber))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(traffic.location?.name ?? "")
                                    .font(.caption)
                                    .frame(width: 85, alignment: .leading)
                            }
                            .padding(.leading)
                            
                            VStack(spacing: 2) {
                                Text(traffic.dateIn?.formatted(.dateTime.hour().minute()) ?? "***")
                                Text(traffic.driverNameIn ?? "n/a")
                                    .font(.caption)
                            }
                            .frame(width: 80, alignment: .center)
                            
                            VStack(spacing: 2) {
                                Text(traffic.dateOut?.formatted(.dateTime.hour().minute()) ?? "")
                                Text(traffic.driverNameOut ?? "")
                                    .font(.caption)
                            }
                            .frame(width: 80, alignment: .center)
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
