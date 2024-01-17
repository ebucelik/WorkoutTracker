//
//  Login.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 17.01.24.
//

import Foundation

struct Login: Codable, Equatable {
    var username: String
    var password: String

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

extension Login {
    static var empty: Login {
        Login(username: "", password: "")
    }
}
