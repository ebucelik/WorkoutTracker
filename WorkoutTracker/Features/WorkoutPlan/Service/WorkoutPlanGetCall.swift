//
//  WorkoutPlanGetCall.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 20.01.24.
//

import Foundation

struct WorkoutPlanGetCall: Call {
    typealias Response = [WorkoutPlan]

    var resource: String = "workoutplans"
    var httpMethod: HTTPMethod = .GET
    var path: String

    init(username: String) {
        self.path = "http://localhost:8080/api/v1/" + resource
        self.path.append("/\(username)")
    }
}
