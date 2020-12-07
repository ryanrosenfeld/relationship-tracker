//
//  ImportantDate.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 12/5/20.
//

import Foundation

struct ImportantDate {
    static let types = ["Birthday", "Anniversary", "Custom"]
    static let days = 1 ..< 31
    static let months = 1 ..< 13
    static let years = 1900 ..< Calendar.current.component(.year, from: Date()) + 1

    var type = 0
    var customType = ""
    var day = 1
    var month = 1
    var year = Calendar.current.component(.year, from: Date())
}

