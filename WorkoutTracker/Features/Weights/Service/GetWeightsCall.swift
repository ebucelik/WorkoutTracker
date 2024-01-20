//
//  GetWeightsCall.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 20.01.24.
//

import Foundation

struct GetWeightsCall: Call {
    typealias Response = Weights

    var resource: String = "weights"
    var httpMethod: HTTPMethod = .GET
    var path: String

    init(username: String) {
        self.path = "http://localhost:8080/api/v1/" + resource
        self.path.append("/\(username)")
    }
}
