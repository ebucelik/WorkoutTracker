//
//  SideMenuView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 16.01.24.
//

import SwiftUI

struct SideMenuView: View {
    @Binding
    var isPresenting: Bool
    var content: AnyView
    var edgeTransition: AnyTransition = .move(edge: .leading)

    var body: some View {
        ZStack(alignment: .bottom) {
            if isPresenting {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPresenting.toggle()
                    }

                content
                    .transition(edgeTransition)
                    .background(Color.clear)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(
            .easeInOut,
            value: isPresenting
        )
    }
}
