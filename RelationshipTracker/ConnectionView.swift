//
//  ConnectionView.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 11/29/20.
//

import SwiftUI

struct ConnectionView: View {
    let connection: Contact
    
    var body: some View {
        Text("This is where the deetz go")
            .navigationBarTitle(connection.name)
    }
}

struct ConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        let contact = Contact(name: "Grammy", relationship: "Grandma", notes: "Notes go here")
        ConnectionView(connection: contact)
    }
}
