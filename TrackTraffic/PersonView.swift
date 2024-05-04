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
    @State private var path = [Person]()
    @Query var people: [Person]
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(people) { person in
                    NavigationLink(value: person) {
                        Text(person.name)
                    }
                }
                .onDelete(perform: deletePeople)
            }
            .navigationTitle("Drivers")
            .navigationDestination(for: Person.self) { person in
                EditPersonView(person: person)
            }
            .toolbar {
                Button("Add Driver", systemImage: "plus", action: addPerson)
            }
        }
        
    }
    
    func addPerson() {
        let person = Person(name: "")
        modelContext.insert(person)
        path.append(person)
    }
    
    func deletePeople(at offsets: IndexSet) {
        for offset in offsets {
            let person = people[offset]
            modelContext.delete(person)
        }
    }
}
