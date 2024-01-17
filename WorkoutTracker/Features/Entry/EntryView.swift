//
//  EntryView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 17.01.24.
//

import SwiftUI

struct EntryView: View {

    @Binding
    var isUserLoggedIn: Bool
    @State
    var showRegisterView: Bool = false

    var body: some View {
        if showRegisterView {
            RegisterView(
                isUserLoggedIn: $isUserLoggedIn,
                showRegisterView: $showRegisterView
            )
        } else {
            LoginView(
                isUserLoggedIn: $isUserLoggedIn,
                showRegisterView: $showRegisterView
            )
        }
    }
}

#Preview {
    EntryView(isUserLoggedIn: .constant(false))
}
