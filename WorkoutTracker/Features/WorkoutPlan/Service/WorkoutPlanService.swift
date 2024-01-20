//
//  WorkoutPlanService.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 20.01.24.
//

import Foundation

protocol WorkoutPlanServiceProtocol {
    func addWorkoutPlan(_ workoutPlan: WorkoutPlan) async throws -> WorkoutPlan
    func getWorkoutPlans(by username: String) async throws -> [WorkoutPlan]
}

class WorkoutPlanService: BackendClient, WorkoutPlanServiceProtocol {
    func addWorkoutPlan(_ workoutPlan: WorkoutPlan) async throws -> WorkoutPlan {
        try await sendRequest(
            call: WorkoutPlanCall(body: workoutPlan)
        )
    }

    func getWorkoutPlans(by username: String) async throws -> [WorkoutPlan] {
        try await sendRequest(
            call: WorkoutPlanGetCall(username: username)
        )
    }
}
