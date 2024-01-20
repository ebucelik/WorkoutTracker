//
//  WorkoutPlanCall.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 20.01.24.
//

import Foundation

struct WorkoutPlanCall: Call {
    typealias Response = WorkoutPlan

    var resource: String = "workoutplan"
    var httpMethod: HTTPMethod = .POST
    var body: Codable?

    init(body: WorkoutPlan) {
        self.body = body
    }
}
