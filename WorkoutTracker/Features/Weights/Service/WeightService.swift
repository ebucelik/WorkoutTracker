//
//  WeightService.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 20.01.24.
//

import Foundation

protocol WeightServiceProtocol {
    func addWeight(_ weight: Weight) async throws -> Weight
    func getWeights(by username: String) async throws -> Weights
}

class WeightService: BackendClient, WeightServiceProtocol {
    func addWeight(_ weight: Weight) async throws -> Weight {
        try await sendRequest(
            call: AddWeightCall(body: weight)
        )
    }

    func getWeights(by username: String) async throws -> Weights {
        try await sendRequest(
            call: GetWeightsCall(username: username)
        )
    }
}
