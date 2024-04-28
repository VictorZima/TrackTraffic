//
//  DatePickerTest.swift
//  TrackTraffic
//
//  Created by VictorZima on 27/04/2024.
//

import SwiftUI

struct DatePickerTest: View {
    @State private var selectedDate = Date()
    var body: some View {
        VStack(spacing: 20) {
                    DatePicker("Default Style", selection: $selectedDate)
                        .datePickerStyle(DefaultDatePickerStyle())
                    
                    DatePicker("Wheel Style", selection: $selectedDate)
                        .datePickerStyle(WheelDatePickerStyle())
                    
                    DatePicker("Compact Style", selection: $selectedDate)
                        .datePickerStyle(CompactDatePickerStyle())
                    
                    DatePicker("Graphical Style", selection: $selectedDate)
                        .datePickerStyle(GraphicalDatePickerStyle())

                }
    }
}

#Preview {
    DatePickerTest()
}
