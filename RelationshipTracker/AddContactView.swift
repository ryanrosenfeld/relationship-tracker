//
//  AddContactView.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 11/29/20.
//

import SwiftUI

class AddContactData: ObservableObject {
    @Published var name = ""
    @Published var remindersEnabled = false
    @Published var contactFrequency = ContactFrequency()
    @Published var importantDates = [ImportantDate]()
}

struct AddContactView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var data = AddContactData()
    
    @State private var addImportantDateShown = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $data.name)
                }
                
                Section {
                    ReminderFrequencyView(data: data)
                }
                
                Section(header: Text("Important dates")) {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            addImportantDateShown.toggle()
                        }) {
                            HStack {
                                Text("Add a date")
                                Image(systemName: "calendar.badge.plus")
                            }
                        }
                            
                        Spacer()
                    }
                    ForEach(data.importantDates) { date in
                        HStack {
                            Text(date.typeDisplay)
                            Spacer()
                            Text(date.dateDisplay)
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddExtraDetailsView()) {
                        Text("Extra details")
                    }
                }
            }
            .navigationBarTitle(data.name == "" ? "New connection" : data.name)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Add") {
                saveContact()
            })
            .sheet(isPresented: $addImportantDateShown) {
                AddImportantDateView(data: data)
            }
        }
    }
    
    func saveContact() {
        let connection = Connection(context: moc)
        connection.name = data.name
        connection.remindersEnabled = data.remindersEnabled
        connection.daysPerReminder = Int16(data.contactFrequency.daysPerReminder)
        try? self.moc.save()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
