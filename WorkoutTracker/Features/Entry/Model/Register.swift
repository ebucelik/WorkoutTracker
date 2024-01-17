//
//  Register.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 17.01.24.
//

import Foundation

struct Register: Codable, Equatable {
    var username: String
    var password: String
    var email: String

    init(username: String, password: String, email: String) {
        self.username = username
        self.password = password
        self.email = email
    }
}

extension Register {
    static var empty: Register {
        Register(username: "", password: "", email: "")
    }
}
