//
//  LoginService.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 20.01.24.
//

import Foundation

protocol LoginServiceProtocol {
    func login(_ login: Login) async throws -> Login
}

class LoginService: BackendClient, LoginServiceProtocol {
    func login(_ login: Login) async throws -> Login {
        try await sendRequest(
            call: LoginCall(
                body: login
            )
        )
    }
}
