//
//  AllTrafficView.swift
//  TrackTraffic
//
//  Created by VictorZima on 30/04/2024.
//

import SwiftUI
import SwiftData

struct AllTrafficView: View {
    @Environment(\.modelContext) var modelContex
    @Query var traffics: [Traffic]
    
    var todaysTraffics: [Traffic] {
        let calendar = Calendar.current
        return traffics.filter { traffic in
            if let dateIn = traffic.dateIn, calendar.isDateInToday(dateIn) {
                return true
            }
            if let dateOut = traffic.dateOut, calendar.isDateInToday(dateOut) {
                return true
            }
            return false
        }
    }
    
    var body: some View {
        
        VStack {
            Text("All Traffic")
            Text(Date().formatted(.dateTime.day().month().year()))
                .font(.subheadline)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Name")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Track №")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Time In")
                        .font(.subheadline)
                        .frame(minWidth: 50, alignment: .leading)
                    Text("Time Out")
                        .font(.subheadline)
                        .frame(minWidth: 50, alignment: .leading)
                }
                .padding(.horizontal, 4)
                .background(Color.blue.opacity(0.3))
                .foregroundColor(.white)
                
                List {
                    ForEach(Array(todaysTraffics.enumerated()), id: \.element) { index, traffic in
                        HStack {
                            Text(traffic.driverName)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 6)
                            Text(traffic.trackNumber)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(traffic.dateIn?.formatted(.dateTime.hour().minute()) ?? "***")
                                .frame(minWidth: 50, alignment: .leading)
                            Text(traffic.dateOut?.formatted(.dateTime.hour().minute()) ?? "***")
                                .frame(minWidth: 50, alignment: .leading)
                        }
                        .frame(maxHeight: .infinity)
                        .listRowInsets(EdgeInsets())
                        .background(index % 2 == 0 ? Color.gray.opacity(0.3) : Color.green.opacity(0.3))
                    }
                    .onDelete(perform: deleteTraffic)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.gray.opacity(0.2))
                }
                .listStyle(.plain)
            }
        }
    }
    
    func deleteTraffic(at offsets: IndexSet) {
        for index in offsets {
            let traffic = todaysTraffics[index]
            modelContex.delete(traffic)
            do {
                try modelContex.save()  // Сохраняем изменения в контексте
            } catch {
                print("Failed to save context after deletion: \(error)")
            }
        }
    }
}

//#Preview {
//    AllTrafficView()
//}
