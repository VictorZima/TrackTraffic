//
//  EditLocationView.swift
//  TrackTraffic
//
//  Created by VictorZima on 15/04/2025.
//

import SwiftUI

struct EditLocationView: View {
    @Bindable var location: Location
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $location.name)
                    .textContentType(.name)
            }
        }
        .navigationTitle("Edit Location")
        .navigationBarTitleDisplayMode(.inline)
    }
}
