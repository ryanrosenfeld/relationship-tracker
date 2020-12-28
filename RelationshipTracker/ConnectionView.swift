//
//  ConnectionView.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 11/29/20.
//

import SwiftUI

struct ConnectionView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    let connection: Connection
    
    var body: some View {
        VStack {
            Text("Remind me every \(connection.daysPerReminder) days")
            
            Button(action: deleteConnection) {
                Text("Delete")
            }
        }
        .navigationBarTitle(connection.wrappedName)
    }
    
    func deleteConnection() {
        moc.delete(connection)
        try? moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct ConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionView(connection: Connection())
    }
}
