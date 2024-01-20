//
//  WorkoutAddCall.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 20.01.24.
//

import Foundation

struct WorkoutAddCall: Call {
    typealias Response = Workout

    var resource: String = "workout"
    var httpMethod: HTTPMethod = .POST
    var body: Codable?

    init(body: Workout) {
        self.body = body
    }
}
