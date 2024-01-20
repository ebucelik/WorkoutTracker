//
//  RegisterView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 17.01.24.
//

import SwiftUI

struct RegisterView: View {

    @State
    var register: Register = .empty
    @State
    var message: Message?

    @Binding
    var showRegisterView: Bool
    
    @EnvironmentObject
    var account: Account

    let registerService = RegisterService()

    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)

            Spacer()

            if let message {
                Common.shared.messageView(message: message)
            }

            VStack {
                TextField(text: $register.email) {
                    Text("Email")
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
                TextField(text: $register.username) {
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
                SecureField(text: $register.password) {
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
                    Text("Already have an account? Login now.")
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
                        if !register.email.isEmpty,
                           !register.password.isEmpty,
                           !register.username.isEmpty {
                            Task {
                                do {
                                    message = nil

                                    let responseRegister = try await registerService.register(register)

                                    account.username = responseRegister.username
                                    account.email = responseRegister.email
                                    account.password = responseRegister.password

                                    UserDefaults.standard.setValue(responseRegister.username, forKey: "username")
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
                        Text("REGISTER")
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
    RegisterView(
        register: .empty,
        showRegisterView: .constant(false)
    )
}
