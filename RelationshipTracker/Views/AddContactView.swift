//
//  AddContactView.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 11/29/20.
//

import SwiftUI

struct AddContactView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var data = ConnectionFormData()
    
    @State private var addImportantDateShown = false
        
    var body: some View {
        NavigationView {
            ConnectionForm(data: data)
            .navigationBarTitle(data.name == "" ? "New connection" : data.name)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Add") {
                saveContact()
            })
            .sheet(isPresented: $addImportantDateShown) {
                AddImportantDateView(data: data).environment(\.managedObjectContext, self.moc)
            }
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

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
