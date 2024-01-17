//
//  LoginView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 17.01.24.
//

import SwiftUI

struct LoginView: View {

    @State
    var login: Login = .empty
    @Binding
    var isUserLoggedIn: Bool
    @Binding
    var showRegisterView: Bool

    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)

            Spacer()

            VStack {
                TextField(text: $login.username) {
                    Text("Username")
                }
                .frame(maxWidth: .infinity)
                .textInputAutocapitalization(.never)
            }
            .padding()
            .background(.gray.opacity(0.2))
            .clipShape(
                RoundedRectangle(
                    cornerSize: .init(width: 8, height: 8)
                )
            )

            VStack {
                SecureField(text: $login.password) {
                    Text("Password")
                }
                .frame(maxWidth: .infinity)
                .textInputAutocapitalization(.never)
            }
            .padding()
            .background(.gray.opacity(0.2))
            .clipShape(
                RoundedRectangle(
                    cornerSize: .init(width: 8, height: 8)
                )
            )

            Button(
                action: {
                    showRegisterView.toggle()
                },
                label: {
                    Text("Don't have an account? Register now.")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.black)
                }
            )
            .padding(.top, 8)

            Spacer()

            VStack {
                Button(
                    action: {
                        // TODO: Login
                        isUserLoggedIn.toggle()
                    },
                    label: {
                        Text("LOGIN")
                            .font(.title2)
                    }
                )
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .contentShape(Rectangle())
        .onTapGesture {
            Common.shared.hideKeyboard()
        }
    }
}

#Preview {
    LoginView(
        login: .empty,
        isUserLoggedIn: .constant(false),
        showRegisterView: .constant(false)
    )
}
