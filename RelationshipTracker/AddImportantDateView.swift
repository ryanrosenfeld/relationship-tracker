//
//  AddImportantDateView.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 12/9/20.
//

import SwiftUI

struct AddImportantDateView: View {
    @ObservedObject var data: AddContactData
    @State private var draftImportantDate = ImportantDate()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Picker(selection: $draftImportantDate.type, label: Text("Type")) {
                    ForEach(0..<ImportantDate.types.count) {
                        Text(ImportantDate.types[$0])
                    }
                }
                
                if draftImportantDate.usingCustomType {
                    TextField("Custom type", text: $draftImportantDate.customType)
                }
                
                HStack {
                    Text("Date")
                    
                    Spacer()
                    
                    Picker(draftImportantDate.month == 0 ? "Month" : "\(draftImportantDate.month)", selection: $draftImportantDate.month) {
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
                    
                    Picker(draftImportantDate.day == 0 ? "Day" : "\(draftImportantDate.day)", selection: $draftImportantDate.day) {
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
                    
                    Picker(draftImportantDate.year == 0 ? "Year" : "\(draftImportantDate.year)", selection: $draftImportantDate.year) {
                        ForEach(1900..<2021) {
                            Text(String($0))
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }

                HStack {
                    Spacer()
                    Button(action: saveDate) {
                        HStack {
                            Text("Save")
                        }
                    }
                    Spacer()
                }
            }
            .navigationBarTitle("New date")
        }
    }
    
    func saveDate() {
        self.data.importantDates.append(draftImportantDate)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddImportantDateView_Previews: PreviewProvider {
    static var previews: some View {
        let data = AddContactData()
        AddImportantDateView(data: data)
    }
}
