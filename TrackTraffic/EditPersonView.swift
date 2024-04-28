//
//  EditPersonView.swift
//  TrackTraffic
//
//  Created by VictorZima on 23/04/2024.
//

import SwiftUI

struct EditPersonView: View {
    @Bindable var person: Person
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $person.name)
                    .textContentType(.name)
            }
        }
        .navigationTitle("Edit Driver")
        .navigationBarTitleDisplayMode(.inline)
    }
}
//
//#Preview {
//    EditPersonView()
//}
