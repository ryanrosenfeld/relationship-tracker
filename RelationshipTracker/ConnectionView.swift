//
//  ConnectionView.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 11/29/20.
//

import SwiftUI

struct ConnectionView: View {
    let connection: Connection
    
    var body: some View {
        Text("This is where the deetz go")
            .navigationBarTitle(connection.wrappedName)
    }
}

struct ConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionView(connection: Connection())
    }
}
