//
//  EditConnectionView.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 3/13/21.
//

import SwiftUI
import CoreData

struct EditConnectionView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    var connection: Connection
    @ObservedObject var data = ConnectionFormData()
    
    @State private var addImportantDateShown = false
    
    init(connection: Connection) {
        self.connection = connection
        data.name = connection.wrappedName
        data.remindersEnabled = connection.remindersEnabled
    }
        
    var body: some View {
        ConnectionForm(data: data)
        .navigationBarTitle(data.name)
        .sheet(isPresented: $addImportantDateShown) {
            AddImportantDateView(data: data).environment(\.managedObjectContext, self.moc)
        }
    }
    
    func saveContact() {
        let connection = Connection(context: moc)
        connection.name = data.name
        connection.remindersEnabled = data.remindersEnabled
        connection.daysPerReminder = Int16(data.contactFrequency.daysPerReminder)
        
        for date in data.importantDates {
            date.connection = connection
        }

        try? self.moc.save()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct EditConnectionView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let connection = Connection(context: moc)
        connection.name = "Dad"
        connection.daysPerReminder = 3
        connection.remindersEnabled = true
        
        let rememberedDate = RememberedDate(context: moc)
        rememberedDate.date = Date.init()
        rememberedDate.type = "Birthday"
        rememberedDate.connection = connection

        return EditConnectionView(connection: connection)
    }
}
