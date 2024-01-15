//
//  APIError.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 15.01.24.
//

import Foundation

public enum APIError: Error {
    case error(Error)
    case unexpectedError(String)
    case notFound
    case notModified
    case unauthorized
    case unknown
}

extension APIError: Equatable {
    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case let (.error(lhsError), .error(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription

        case let (.unexpectedError(lhsError), .unexpectedError(rhsError)):
            return lhsError == rhsError

        case (.notFound, .notFound):
            return true

        case (.notModified, .notModified):
            return true

        case (.unauthorized, .unauthorized):
            return true

        case (.unknown, .unknown):
            return true

        default:
            return false
        }
    }
}
