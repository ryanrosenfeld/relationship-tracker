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
    
    var frequencyValue: Int {
        ContactFrequency.frequencies[frequency]
    }
    
    var frequencyDisplay: String {
        "\(frequencyValue)x"
    }
    
    var timeUnitsDisplay: String {
        ContactFrequency.timeUnits[timeUnit]
    }
    
    var display: String {
        "\(frequencyDisplay) per \(timeUnitsDisplay)"
    }
    
    var daysPerReminder: Int {
        switch timeUnit {
        case 0:
            return 1
        case 1:
            return 7 / frequencyValue
        case 2:
            return 30 / frequencyValue
        case 3:
            return 365 / frequencyValue
        default:
            return 7
        }
    }
    
    static func frequencyDisplay(index: Int) -> String {
        return "\(ContactFrequency.frequencies[index])x"
    }
    
    static func timeUnitsDisplay(index: Int) -> String {
        return "\(ContactFrequency.timeUnits[index])"
    }
}
