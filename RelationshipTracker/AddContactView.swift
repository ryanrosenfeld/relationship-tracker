//
//  AddContactView.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 11/29/20.
//

import SwiftUI

struct AddContactView: View {
    @ObservedObject var connections: Connections
    @State private var contact = Contact(name: "", relationship: "", notes: "")
    @State private var contactFrequency = ContactFrequency()
    @State private var contactRemindersEnabled = false
    @Environment(\.presentationMode) var presentationMode
    @State private var importantDates = [ImportantDate]()
    @State private var draftImportantDate = ImportantDate()
    @State private var date = Date()
    @State private var addImportantDateShown = false
    @State private var day = 0
    @State private var month = 0
    @State private var year = 0
    @State private var customType = ""
    
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
                
                Section {
                    HStack {
                        Text("Important dates")
                        Spacer()
                        Button(action: {
                            self.addImportantDateShown = !addImportantDateShown
                        }) {
                            if !addImportantDateShown {
                                HStack {
                                    Text("Add")
                                    Image(systemName: "calendar.badge.plus")
                                }
                            } else {
                                HStack {
                                    Text("Cancel")
                                }
                            }
                        }
                    }
                    
                    if (addImportantDateShown) {
                        Picker(selection: $draftImportantDate.type, label: Text("Type")) {
                            ForEach(0..<ImportantDate.types.count) {
                                Text(ImportantDate.types[$0])
                            }
                        }
                        
                        HStack {
                            Text("Date")
                            
                            Spacer()
                            
                            Picker(month == 0 ? "Month" : "\(month)", selection: $month) {
                                ForEach(0..<13) {
                                    if $0 == 0 {
                                        Text("Month")
                                    } else {
                                        Text("\($0)")
                                    }
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            
                            Text("/")
                            
                            Picker(day == 0 ? "Day" : "\(day)", selection: $day) {
                                ForEach(0..<31) {
                                    if $0 == 0 {
                                        Text("Day")
                                    } else {
                                        Text("\($0)")
                                    }
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            
                            Text("/")
                            
                            Picker(year == 0 ? "Year" : "\(year)", selection: $year) {
                                ForEach(1900..<2021) {
                                    Text(String($0))
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }

                        HStack {
                            Spacer()
                            Button(action: {
                                self.addImportantDateShown = false
                            }) {
                                HStack {
                                    Text("Save")
                                }
                            }
                            Spacer()
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: Text("Hi")) {
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
        }
    }
    
    func saveContact() {
        connections.contacts.append(contact)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        let connections = Connections()
        AddContactView(connections: connections)
    }
}
