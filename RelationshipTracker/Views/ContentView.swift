//
//  ContentView.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 11/28/20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Connection.entity(), sortDescriptors: []) var connectionData: FetchedResults<Connection>
    
    @ObservedObject var connections = Connections()
    @State private var isAddShown = false
    @State private var isOpen = true
    
    var body: some View {
        NavigationView {
            List {
                ForEach(connectionData) { connection in
                    NavigationLink(destination: ConnectionView(connection: connection).environment(\.managedObjectContext, self.moc)) {
                        HStack {
                            Text(connection.wrappedName)
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
                AddContactView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
