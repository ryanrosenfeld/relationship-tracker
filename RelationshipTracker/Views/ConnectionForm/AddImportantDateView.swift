//
//  AddImportantDateView.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 12/9/20.
//

import SwiftUI

struct AddImportantDateView: View {
    @ObservedObject var data: ConnectionFormData
    @State private var draftImportantDate = ImportantDate()
    
    @Environment(\.managedObjectContext) var moc
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
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    func saveDate() {
        var dateComponents = DateComponents()
        dateComponents.year = draftImportantDate.year
        dateComponents.month = draftImportantDate.month
        dateComponents.day = draftImportantDate.day
        
        let userCalendar = Calendar(identifier: .gregorian)
        let dateToRemember = userCalendar.date(from: dateComponents)
        
        let date = RememberedDate(context: moc)
        date.type = draftImportantDate.typeDisplay
        date.date = dateToRemember
        data.importantDates.append(date)
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddImportantDateView_Previews: PreviewProvider {
    static var previews: some View {
        AddImportantDateView(data: ConnectionFormData())
    }
}
