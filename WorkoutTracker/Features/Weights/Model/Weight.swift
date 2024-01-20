//
//  Weight.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 19.01.24.
//

import Foundation

struct Weights: Codable, Hashable {
    var weights: [Weight]
}

struct Weight: Codable, Hashable {
    var username: String?
    var weight: Float
    var date: String

    init(username: String? = nil, weight: Float, date: String) {
        self.username = username
        self.weight = weight
        self.date = date
    }
}

extension Weight {
    static var empty: Weight {
        Weight(
            username: nil,
            weight: 0.0,
            date: ""
        )
    }

    static var mock: Weight {
        Weight(
            username: nil,
            weight: 79.3,
            date: "2024-01-01"
        )
    }

    static var mock1: Weight {
        Weight(
            username: nil,
            weight: 80.1,
            date: "2024-01-12"
        )
    }
}

extension Sequence where Iterator.Element == Weight {
    static var weights: [Weight] {
        [
            .mock,
            .mock1
        ]
    }
}

//{
//    "username": "ebucelik",
//    "weight": "80"
//    "date": "27-12-2023" (String)
//}
