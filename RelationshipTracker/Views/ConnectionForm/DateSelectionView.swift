//
//  DateSelectionView.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 12/29/20.
//

import SwiftUI

struct DateSelectionView: View {
    @Binding var month: Int
    @Binding var day: Int
    @Binding var year: Int
    
    var currentYear = Calendar.current.component(.year, from: Date())
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                Picker("Month", selection: $month) {
                    ForEach(0..<months.count) {
                        Text(self.months[$0])
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(maxWidth: geo.size.width / 2.25)
                .clipped()
                                    
                Picker("Day", selection: $day) {
                    ForEach(0..<31) {
                        Text("\($0+1)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(maxWidth: geo.size.width / 4)
                .clipped()
                                    
                Picker(year == 0 ? "Year" : String(year), selection: $year) {
                    ForEach(1..<currentYear + 1) {
                        if ($0 == currentYear) {
                            Text("---")
                        } else {
                            Text(String($0 + 1))
                        }
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(maxWidth: geo.size.width / 3.25)
                .clipped()
            }
        }
        .frame(minHeight: 225)
    }
}

struct DateSelectionView_Previews: PreviewProvider {
    @State static var month = 0
    @State static var day = 0
    @State static var year = Calendar.current.component(.year, from: Date()) - 1
    
    static var previews: some View {
        DateSelectionView(month: $month, day: $day, year: $year)
    }
}
