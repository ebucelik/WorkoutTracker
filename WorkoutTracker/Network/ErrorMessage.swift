//
//  ErrorMessage.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 15.01.24.
//

import Foundation

public struct Message: Codable, Equatable {
    public let message: String

    public init(message: String) {
        self.message = message
    }
}
