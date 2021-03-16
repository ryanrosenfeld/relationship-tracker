//
//  BottomSheetView.swift
//  RelationshipTracker
//
//  Created by Ryan Rosenfeld on 12/31/20.
//

import SwiftUI

fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let minHeightRatio: CGFloat = 0.3
}

struct BottomSheetView<Content: View>: View {
    @Binding var isOpen: Bool

    let height: CGFloat
    let content: Content
    
    init(isOpen: Binding<Bool>, height: CGFloat, @ViewBuilder content: () -> Content) {
        self.height = height
        self.content = content()
        self._isOpen = isOpen
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Color.gray
                    .frame(width: geometry.size.width, height: geometry.size.height)
                content
                    .frame(width: geometry.size.width, height: height, alignment: .top)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(Constants.radius)
                    .frame(height: geometry.size.height, alignment: .bottom)
                    .animation(.easeIn)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct BottomSheetView_Previews: PreviewProvider {
    @State static var isOpen = true
    
    static var previews: some View {
        BottomSheetView(isOpen: $isOpen, height: 500) {
            ZStack {
                Color.green
            }
        }
    }
}
