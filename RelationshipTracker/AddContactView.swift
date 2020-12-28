//
//  AddContactView.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 11/29/20.
//

import SwiftUI

class AddContactData: ObservableObject {
    @Published var importantDates = [ImportantDate]()
}

struct AddContactView: View {
    @Environment(\.managedObjectContext) var moc
//    @State private var connection: Connection
    
    @State private var contact = Contact(name: "", relationship: "", notes: "")
    @State private var contactFrequency = ContactFrequency()
    @State private var contactRemindersEnabled = false
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var data = AddContactData()
    
    @State private var addImportantDateShown = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $contact.name)
                }
                
                Section {
                    Toggle(isOn: $contactRemindersEnabled) {
                        VStack(alignment: .leading) {
                            Text("Reminders")
                            if contactRemindersEnabled {
                                Text(contactFrequency.display)
                                    .font(.footnote)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    
                    if contactRemindersEnabled {
                        Picker(selection: $contactFrequency.frequency, label: Text("")) {
                            ForEach(1..<6) {
                                Text("\($0)x")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Picker(selection: $contactFrequency.timeUnit, label: Text("per")) {
                            ForEach(0..<ContactFrequency.timeUnits.count) {
                                Text(ContactFrequency.timeUnitsDisplay(index: $0))
                            }
                        }
                    }
                }
                
                Section(header: Text("Important dates")) {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            self.addImportantDateShown = !addImportantDateShown
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
            .navigationBarTitle(contact.name == "" ? "New connection" : contact.name)
            .navigationBarItems(leading: Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Add") {
                saveContact()
            })
            .sheet(isPresented: $addImportantDateShown) {
                AddImportantDateView(data: self.data)
            }
        }
    }
    
    func saveContact() {
        let connection = Connection(context: moc)
        connection.name = contact.name
        try? self.moc.save()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
