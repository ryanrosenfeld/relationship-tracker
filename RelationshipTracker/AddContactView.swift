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
    
    @State private var name = ""
    @State private var remindersEnabled = false
    @State private var contactFrequency = ContactFrequency()
    @State private var contactRemindersEnabled = false
    @State private var importantDates = [ImportantDate]()
    @State private var addImportantDateShown = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                }
                
                Section {
                    Toggle(isOn: $remindersEnabled) {
                        VStack(alignment: .leading) {
                            Text("Reminders")
                            if remindersEnabled {
                                Text(contactFrequency.display)
                                    .font(.footnote)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    
                    if remindersEnabled {
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
                            self.addImportantDateShown.toggle()
                        }) {
                            HStack {
                                Text("Add a date")
                                Image(systemName: "calendar.badge.plus")
                            }
                        }
                            
                        Spacer()
                    }
                    ForEach(importantDates) { date in
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
            .navigationBarTitle(name == "" ? "New connection" : name)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Add") {
                saveContact()
            })
            .sheet(isPresented: $addImportantDateShown) {
                AddImportantDateView(dates: importantDates)
            }
        }
    }
    
    func saveContact() {
        let connection = Connection(context: moc)
        connection.name = name
        connection.remindersEnabled = remindersEnabled
        connection.daysPerReminder = Int16(contactFrequency.daysPerReminder)
        try? self.moc.save()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
