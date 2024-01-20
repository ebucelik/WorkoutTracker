//
//  Call.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 20.01.24.
//

import Foundation

struct LoginCall: Call {
    typealias Response = Login

    var resource: String = "login"
    var httpMethod: HTTPMethod = .POST
    var body: Codable?

    init(body: Login) {
        self.body = body
    }
}
