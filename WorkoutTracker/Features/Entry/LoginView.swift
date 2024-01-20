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
    @State
    var message: Message?

    @Binding
    var showRegisterView: Bool

    @EnvironmentObject
    var account: Account

    let loginService = LoginService()

    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)

            Spacer()

            if let message {
                Common.shared.messageView(message: message)
            }

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
                        if !login.password.isEmpty,
                           !login.username.isEmpty {
                            Task {
                                do {
                                    message = nil

                                    let responseLogin = try await loginService.login(login)

                                    account.username = responseLogin.username
                                    account.password = responseLogin.password

                                    UserDefaults.standard.setValue(responseLogin.username, forKey: "username")
                                } catch {
                                    if let error = error as? APIError {
                                        switch error {
                                        case .unauthorized(let message), .unknown(let message):
                                            self.message = message
                                        default:
                                            break
                                        }
                                    }
                                }
                            }
                        }
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
        showRegisterView: .constant(false)
    )
}
