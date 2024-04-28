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
            Section {
                TextField("Number", text: $track.number)
                    .keyboardType(.numberPad)
                TextField("Model", text: $track.model)
                    .textContentType(.name)
            }
        }
        .navigationTitle("Edit Track")
        .navigationBarTitleDisplayMode(.inline)
    }
}
//
//#Preview {
//    EditTrackView()
//}
