//
//  Connection+CoreDataProperties.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 3/15/21.
//
//

import Foundation
import CoreData


extension Connection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Connection> {
        return NSFetchRequest<Connection>(entityName: "Connection")
    }

    @NSManaged public var daysPerReminder: Int16
    @NSManaged public var name: String?
    @NSManaged public var remindersEnabled: Bool
    @NSManaged public var notes: String?
    @NSManaged public var importantDates: NSSet?

    var wrappedName: String {
        name ?? "Unknown name"
    }
    
    var wrappedNotes: String {
        notes ?? "Unknown notes"
    }
    
    var importantDateArray: [RememberedDate] {
        let set = importantDates as? Set<RememberedDate> ?? []
        return Array(set)
    }
}

// MARK: Generated accessors for importantDates
extension Connection {

    @objc(addImportantDatesObject:)
    @NSManaged public func addToImportantDates(_ value: RememberedDate)

    @objc(removeImportantDatesObject:)
    @NSManaged public func removeFromImportantDates(_ value: RememberedDate)

    @objc(addImportantDates:)
    @NSManaged public func addToImportantDates(_ values: NSSet)

    @objc(removeImportantDates:)
    @NSManaged public func removeFromImportantDates(_ values: NSSet)

}

extension Connection : Identifiable {

}
