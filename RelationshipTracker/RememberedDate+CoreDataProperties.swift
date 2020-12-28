//
//  RememberedDate+CoreDataProperties.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 12/28/20.
//
//

import Foundation
import CoreData


extension RememberedDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RememberedDate> {
        return NSFetchRequest<RememberedDate>(entityName: "RememberedDate")
    }

    @NSManaged public var date: Date?
    @NSManaged public var type: String?
    @NSManaged public var connection: Connection?

}

extension RememberedDate : Identifiable {

}
