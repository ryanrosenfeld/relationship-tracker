//
//  Contact.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 11/29/20.
//

import Foundation

struct Contact: Identifiable {
    let id = UUID()
    var name = ""
    var relationship = ""
    var notes = ""
    var contactFrequency = ContactFrequency()
    var importantDates = [ImportantDate]()
}
