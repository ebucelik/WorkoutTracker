//
//  Workout.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 17.01.24.
//

import Foundation

struct Workout: Codable, Hashable {
    struct Exercise: Codable, Hashable {
        let exercise: String
        let set: Int
        let weight: String
        let reps: Int

        init(exercise: String, set: Int, weight: String, reps: Int) {
            self.exercise = exercise
            self.set = set
            self.weight = weight
            self.reps = reps
        }
    }

    let workoutname: String
    let workoutdate: String
    let workouts: [Exercise]

    init(workoutname: String, workoutdate: String, workouts: [Exercise]) {
        self.workoutname = workoutname
        self.workoutdate = workoutdate
        self.workouts = workouts
    }
}

extension Workout {
    static var mock: Workout {
        Workout(
            workoutname: "Pushday",
            workoutdate: "2024-01-01",
            workouts: []
        )
    }
}

extension Sequence {
    static var workouts: [Workout] {
        [
            .mock,
            Workout(
                workoutname: "Pullday",
                workoutdate: "2024-01-22",
                workouts: []
            ),
            Workout(
                workoutname: "Legday",
                workoutdate: "2024-02-01",
                workouts: []
            )
        ]
    }
}
