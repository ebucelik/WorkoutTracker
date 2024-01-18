//
//  EntryView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 17.01.24.
//

import SwiftUI

struct EntryView: View {
    @State
    var showRegisterView: Bool = false

    @EnvironmentObject
    var account: Account

    @Environment(\.dismiss)
    var dismiss

    var body: some View {
        ZStack {
            if showRegisterView {
                RegisterView(
                    showRegisterView: $showRegisterView
                )
            } else {
                LoginView(
                    showRegisterView: $showRegisterView
                )
            }
        }
        .onReceive(
            account.$username,
            perform: { username in
                if !username.isEmpty {
                    dismiss()
                }
            }
        )
    }
}

#Preview {
    EntryView()
}
