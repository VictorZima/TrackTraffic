//
//  AllTrafficViewModel.swift
//  TrackTraffic
//
//  Created by VictorZima on 19/04/2025.
//

import Foundation
import SwiftUI
import SwiftData

final class AllTrafficViewModel: ObservableObject {
    @Published var todaysTraffics: [Traffic] = []
    
    func updateTraffics(_ allTraffics: [Traffic]) {
        let calendar = Calendar.current
        todaysTraffics = allTraffics.filter { traffic in
            if let dateIn = traffic.dateIn, calendar.isDateInToday(dateIn) {
                return true
            }
            if let dateOut = traffic.dateOut, calendar.isDateInToday(dateOut) {
                return true
            }
            return false
        }
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
            let name = traffic.driverNameIn ?? "n/a"
            let trackNo = traffic.trackNumber
            let timeIn = traffic.dateIn?.formatted(.dateTime.hour().minute()) ?? "N/A"
            let timeOut = traffic.dateOut?.formatted(.dateTime.hour().minute()) ?? "N/A"
            html += "<tr><td>\(name)</td><td>\(trackNo)</td><td>\(timeIn)</td><td>\(timeOut)</td></tr>"
        }
        html += "</table></body></html>"
        return html
    }
    
    func deleteTraffic(at offsets: IndexSet, in context: ModelContext) {
        for index in offsets {
            let traffic = todaysTraffics[index]
            context.delete(traffic)
        }
        do {
            try context.save()
        } catch {
            print("Failed to save context after deletion: \(error)")
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
