//
//  PersonViewModel.swift
//  TrackTraffic
//
//  Created by VictorZima on 26/04/2025.
//

import SwiftUI
import SwiftData

final class PersonViewModel: ObservableObject {
    @Published var path = [Person]()

    func addPerson(context: ModelContext) {
        let person = Person(name: "")
        context.insert(person)
        path.append(person)
    }

    func deletePerson(at offsets: IndexSet, from people: [Person], context: ModelContext) {
        for index in offsets {
            let p = people[index]
            context.delete(p)
        }
        try? context.save()
    }
}
