//
//  RegisterService.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 20.01.24.
//

import Foundation

protocol RegisterServiceProtocol {
    func register(_ register: Register) async throws -> Register
}

class RegisterService: BackendClient, RegisterServiceProtocol {
    func register(_ register: Register) async throws -> Register {
        try await sendRequest(
            call: RegisterCall(
                body: register
            )
        )
    }
}
