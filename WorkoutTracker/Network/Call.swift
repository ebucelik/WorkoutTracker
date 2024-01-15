//
//  Call.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 15.01.24.
//

import Foundation

protocol Call {
    associatedtype Response: Codable

    var domain: String { get }
    var resource: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var body: Codable? { get }
    var parameters: [String : Any]? { get }
}

extension Call {
    var domain: String { "" }

    var path: String { domain + resource }

    var body: Codable? {
        get { nil }
    }

    var parameters: [String : Any]? {
        get { nil }
    }
}
