//
//  ReminderFrequencyView.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 12/28/20.
//

import SwiftUI

struct ReminderFrequencyView: View {
    @ObservedObject var data: ConnectionFormData
    
    var body: some View {
        Section {
            Toggle(isOn: $data.remindersEnabled) {
                VStack(alignment: .leading) {
                    Text("Reminders")
                    if data.remindersEnabled {
                        Text(data.contactFrequency.display)
                            .font(.footnote)
                            .foregroundColor(.green)
                    }
                }
            }
            
            if data.remindersEnabled {
                VStack {
                    Picker(selection: $data.contactFrequency.frequency, label: Text("")) {
                        ForEach(1..<6) {
                            Text("\($0)x")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Picker(selection: $data.contactFrequency.timeUnit, label: Text("per")) {
                        ForEach(0..<ContactFrequency.timeUnits.count) {
                            Text(ContactFrequency.timeUnitsDisplay(index: $0))
                        }
                    }
                }
            }
        }
    }
}

struct ReminderFrequencyView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderFrequencyView(data: ConnectionFormData())
    }
}
