//
//  ConnectionFormData.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 3/13/21.
//

import Foundation

class ConnectionFormData: ObservableObject {
    @Published var name = ""
    @Published var remindersEnabled = false
    @Published var contactFrequency = ContactFrequency()
    @Published var importantDates = [RememberedDate]()
}
