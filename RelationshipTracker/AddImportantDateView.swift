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
                Section {
                    Picker(selection: $draftImportantDate.type, label: Text("Type")) {
                        ForEach(0..<ImportantDate.types.count) {
                            Text(ImportantDate.types[$0])
                        }
                    }
                    
                    if draftImportantDate.usingCustomType {
                        TextField("Custom type", text: $draftImportantDate.customType)
                    }
                    
                    DateSelectionView(month: $draftImportantDate.month, day: $draftImportantDate.day, year: $draftImportantDate.year)
                }

                Section {
                    Button(action: saveDate) {
                        Text("Save")
                    }
                }
            }
            .navigationBarTitle("New date")
        }
    }
    
    func saveDate() {
        data.importantDates.append(draftImportantDate)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddImportantDateView_Previews: PreviewProvider {
    static var previews: some View {
        AddImportantDateView(data: AddContactData())
    }
}
