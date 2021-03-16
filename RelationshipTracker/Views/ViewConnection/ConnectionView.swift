//
//  ConnectionView.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 11/29/20.
//

import SwiftUI
import CoreData

struct ConnectionView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var isEditShown = false
    @State private var data = ConnectionFormData()
    
    let connection: Connection
    
    
    var body: some View {
        VStack {
            if (isEditShown) {
                ConnectionForm(data: data)
                    .navigationBarItems(trailing: Button("Done") {
                        isEditShown = false
                    })
            } else {
                Form {
                    Section(header: Text("Reminders")) {
                        Text("Every \(connection.daysPerReminder) days")
                            .font(.title2)
                            .padding()
                    }
                    
                    Section(header: Text("Important Dates")) {
                        ForEach(connection.importantDateArray) { date in
                            HStack {
                                Text("\(date.wrappedType):").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Text(date.wrappedDate, style: .date)
                            }
                        }
                    }
                }
                .navigationBarItems(trailing: Button("Edit") {
                    isEditShown = true
                })
            }
        }
        .navigationBarTitle(connection.wrappedName)
//        .navigationBarItems(trailing: NavigationLink(destination: EditConnectionView(connection: connection).environment(\.managedObjectContext, self.moc)) {
//            Text("Edit")
//        })
        
    }
    
    func deleteConnection() {
        moc.delete(connection)
        try? moc.save()
        presentationMode.wrappedValue.dismiss()
    }
    
    func editConnection() {
        isEditShown = true
    }
}

struct ConnectionView_Previews: PreviewProvider {
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

        return NavigationView {
            ConnectionView(connection: connection)
        }
    }
}
