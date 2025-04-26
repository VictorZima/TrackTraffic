//
//  PersonView.swift
//  TrackTraffic
//
//  Created by VictorZima on 25/04/2024.
//

import SwiftUI
import SwiftData

struct PersonView: View {
    @Environment(\.modelContext) var modelContext
    @Query var people: [Person]
    @StateObject private var viewModel = PersonViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            List {
                ForEach(people) { person in
                    NavigationLink(value: person) {
                        Text(person.name)
                    }
                }
                .onDelete { offsets in
                    viewModel.deletePerson(at: offsets, from: people, context: modelContext)
                }
            }
            .navigationTitle("Drivers")
            .navigationDestination(for: Person.self) { person in
                EditPersonView(person: person)
            }
            .toolbar {
                Button {
                    viewModel.addPerson(context: modelContext)
                } label: {
                    Label("Add Driver", systemImage: "plus")
                }
            }
        }
        
    }
}
