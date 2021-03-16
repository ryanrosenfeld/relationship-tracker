//
//  ConnetionForm.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 3/13/21.
//

import SwiftUI

struct ConnectionForm: View {
    @ObservedObject var data: ConnectionFormData
    @State private var addImportantDateShown = false
    
    var body: some View {
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
                        Text(date.wrappedType)
                        Spacer()
                        Text(date.wrappedDate, style: .date)
                    }
                }
            }
            
            Section {
                NavigationLink(destination: AddExtraDetailsView()) {
                    Text("Extra details")
                }
            }
        }
    }
}

struct ConnetionForm_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionForm(data: ConnectionFormData())
    }
}
