//
//  ContentView.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 11/28/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var connections = Connections()
    @State private var isAddShown = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(connections.contacts) { contact in
                    NavigationLink(destination: ConnectionView(connection: contact)) {
                        HStack {
                            Text(contact.name)
                            Spacer()
                        }
                    }
                }
            }
            .navigationBarTitle("Connections")
            .navigationBarItems(trailing: Button(action: {
                self.isAddShown = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isAddShown) {
                AddContactView(connections: connections)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
