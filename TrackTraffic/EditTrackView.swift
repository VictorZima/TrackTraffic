//
//  EditTrackView.swift
//  TrackTraffic
//
//  Created by VictorZima on 26/04/2024.
//

import SwiftUI

struct EditTrackView: View {
    @Bindable var track: Track
    
    var body: some View {
        Form {
//            Section {
                TextField("Number", text: $track.number)
                    .keyboardType(.numberPad)
                TextField("Model", text: $track.model)
                    .textContentType(.name)
            TextField("Driver", text: .nilCoalescing($track.driverName))
//            TextField("Driver", text: $track.driverName ?? "")
//                TextField("Driver", text: $track.trackOwner)
//                    .textContentType(.name)
//            }
        }
        .navigationTitle("Edit Track")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension Binding {
    static func nilCoalescing(_ source: Binding<String?>) -> Binding<String> {
        Binding<String>(
            get: { source.wrappedValue ?? "" },
            set: { newValue in
                source.wrappedValue = newValue.isEmpty ? nil : newValue
            }
        )
    }
}

//
//#Preview {
//    EditTrackView()
//}
