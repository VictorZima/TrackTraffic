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
            HStack {
                VStack(alignment: .leading) {
                    Text("כל התנועה")
                        .fontWeight(.bold)
                    Text(Date().formatted(.dateTime.day().month().year()))
                        .font(.subheadline)
                }
                Spacer()
                Button {
                    printDocument()
                } label: {
                    Image(systemName: "printer")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            .padding(.horizontal, 10)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("שעת יציאה")
                        .font(.subheadline)
                        .frame(minWidth: 50, alignment: .center)
                    Text("שעת כניסה")
                        .font(.subheadline)
                        .frame(minWidth: 50, alignment: .center)
                    Text("מספר משאית")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("שם הנהג")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
                .padding(.horizontal, 4)
                .background(Color.blue.opacity(0.3))
                .foregroundColor(.white)
                
                List {
                    ForEach(Array(todaysTraffics.enumerated()), id: \.element) { index, traffic in
                        HStack {
                            Text(traffic.dateOut?.formatted(.dateTime.hour().minute()) ?? "***")
                                .frame(minWidth: 50, alignment: .center)
                            Text(traffic.dateIn?.formatted(.dateTime.hour().minute()) ?? "***")
                                .frame(minWidth: 50, alignment: .center)
                            Text(formatTrackNumber(traffic.trackNumber))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            Text(traffic.driverName ?? "n/a")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.horizontal, 6)
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
    
    func printDocument() {
        let printController = UIPrintInteractionController.shared
        
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.jobName = "Today's Traffic Report"
        printInfo.outputType = .general
        
        printController.printInfo = printInfo
        
        let formatter = UIMarkupTextPrintFormatter(markupText: generateHTMLForPrint())
        printController.printFormatter = formatter
        
        printController.present(animated: true, completionHandler: nil)
    }
    
    func generateHTMLForPrint() -> String {
        var html = "<html><body><h1>Today's Traffic Report</h1>"
        html += "<table>"
        for traffic in todaysTraffics {
            let name = traffic.driverName ?? "n/a"
            let trackNo = traffic.trackNumber
            let timeIn = traffic.dateIn?.formatted(.dateTime.hour().minute()) ?? "N/A"
            let timeOut = traffic.dateOut?.formatted(.dateTime.hour().minute()) ?? "N/A"
            html += "<tr><td>\(name)</td><td>\(trackNo)</td><td>\(timeIn)</td><td>\(timeOut)</td></tr>"
        }
        html += "</table></body></html>"
        return html
    }
    
    func deleteTraffic(at offsets: IndexSet) {
        for index in offsets {
            let traffic = todaysTraffics[index]
            modelContex.delete(traffic)
            do {
                try modelContex.save()
            } catch {
                print("Failed to save context after deletion: \(error)")
            }
        }
    }
}
