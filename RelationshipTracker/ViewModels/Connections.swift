//
//  Connections.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 11/29/20.
//

import Foundation

class Connections: ObservableObject {
    @Published var contacts = [Contact]()
}
