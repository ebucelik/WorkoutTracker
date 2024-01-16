//
//  ErrorMessage.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 15.01.24.
//

import Foundation

struct Message: Codable, Equatable {
    public let message: String

    init(message: String) {
        self.message = message
    }
}
