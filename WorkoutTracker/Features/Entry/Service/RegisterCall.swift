//
//  RegisterCall.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 20.01.24.
//

import Foundation

struct RegisterCall: Call {
    typealias Response = Register

    var resource: String = "register"
    var httpMethod: HTTPMethod = .POST
    var body: Codable?

    init(body: Register) {
        self.body = body
    }
}
