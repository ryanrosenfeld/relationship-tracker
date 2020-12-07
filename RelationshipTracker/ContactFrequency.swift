//
//  ContactFrequency.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 11/29/20.
//

import Foundation

struct ContactFrequency {
    static let frequencies = [1, 2, 3, 4, 5]
    static let timeUnits = ["day", "week", "month", "year"]
    
    var frequency = 0
    var timeUnit = 1
    var enabled = false
    
    var frequencyDisplay: String {
        "\(ContactFrequency.frequencies[frequency])x"
    }
    
    var timeUnitsDisplay: String {
        ContactFrequency.timeUnits[timeUnit]
    }
    
    var display: String {
        "\(frequencyDisplay) per \(timeUnitsDisplay)"
    }
    
    static func frequencyDisplay(index: Int) -> String {
        return "\(ContactFrequency.frequencies[index])x"
    }
    
    static func timeUnitsDisplay(index: Int) -> String {
        return "\(ContactFrequency.timeUnits[index])"
    }
}
