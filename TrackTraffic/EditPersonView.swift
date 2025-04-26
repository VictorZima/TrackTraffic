//
//  EditPersonView.swift
//  TrackTraffic
//
//  Created by VictorZima on 23/04/2024.
//

import SwiftUI
import SwiftData

struct EditPersonView: View {
    @Bindable var person: Person
    @Query var locations: [Location]
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $person.name)
                    .textContentType(.name)
                Picker("Location", selection: $person.location) {
                    Text("None").tag(nil as Location?)
                    ForEach(locations, id: \.self) { location in
                        Text(location.name).tag(location as Location?)
                    }
                }
            }
        }
        .navigationTitle("Edit Person")
        .navigationBarTitleDisplayMode(.inline)
    }
}
