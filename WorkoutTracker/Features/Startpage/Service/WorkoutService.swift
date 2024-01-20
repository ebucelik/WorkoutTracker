//
//  WorkoutService.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 20.01.24.
//

import Foundation

protocol WorkoutServiceProtocol {
    func getWorkouts(by username: String) async throws -> [Workout]
    func addWorkout(with workout: Workout) async throws -> Workout
}

class WorkoutService: BackendClient, WorkoutServiceProtocol {
    func getWorkouts(by username: String) async throws -> [Workout] {
        try await sendRequest(
            call: WorkoutGetCall(username: username)
        )
    }

    func addWorkout(with workout: Workout) async throws -> Workout {
        try await sendRequest(
            call: WorkoutAddCall(body: workout)
        )
    }
}
