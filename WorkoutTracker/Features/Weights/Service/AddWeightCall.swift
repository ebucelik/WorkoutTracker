//
//  AddWeightCall.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 20.01.24.
//

import Foundation

struct AddWeightCall: Call {
    typealias Response = Weight
    
    var resource: String = "weight"
    var httpMethod: HTTPMethod = .POST
    var body: Codable?

    init(body: Weight) {
        self.body = body
    }
}
