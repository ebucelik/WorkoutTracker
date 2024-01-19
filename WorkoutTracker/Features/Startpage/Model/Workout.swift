//
//  Workout.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 17.01.24.
//

import Foundation

struct Workout: Codable, Hashable {
    struct Exercise: Codable, Hashable {
        var exercise: String
        var set: Int
        var weight: Float
        var reps: Int

        init(exercise: String, set: Int, weight: Float, reps: Int) {
            self.exercise = exercise
            self.set = set
            self.weight = weight
            self.reps = reps
        }
    }

    var username: String?
    var workoutname: String
    var workoutdate: String
    var workouts: [Exercise]

    init(username: String?, workoutname: String, workoutdate: String, workouts: [Exercise]) {
        self.username = username
        self.workoutname = workoutname
        self.workoutdate = workoutdate
        self.workouts = workouts
    }
}

extension Workout {
    static var empty: Workout {
        Workout(
            username: nil,
            workoutname: "",
            workoutdate: "",
            workouts: []
        )
    }

    static var mock: Workout {
        Workout(
            username: nil,
            workoutname: "Pushday",
            workoutdate: "2024-01-01",
            workouts: .benchpress
        )
    }
}

extension Workout.Exercise {
    static var empty: Workout.Exercise {
        Workout.Exercise(
            exercise: "",
            set: 0,
            weight: 0.0,
            reps: 0
        )
    }
}

extension Sequence where Iterator.Element == Workout {
    static var workouts: [Workout] {
        [
            .mock,
            Workout(
                username: nil,
                workoutname: "Pullday",
                workoutdate: "2024-01-22",
                workouts: .pullups
            ),
            Workout(
                username: nil,
                workoutname: "Legday",
                workoutdate: "2024-02-01",
                workouts: .legpress
            )
        ]
    }
}

extension Sequence where Iterator.Element == Workout.Exercise {
    static var pullups: [Workout.Exercise] {
        [
            Workout.Exercise(
                exercise: "Pullup",
                set: 1,
                weight: 80.0,
                reps: 8
            ),
            Workout.Exercise(
                exercise: "Pullup",
                set: 2,
                weight: 80.0,
                reps: 5
            ),
            Workout.Exercise(
                exercise: "Pullup",
                set: 3,
                weight: 80.0,
                reps: 4
            )
        ]
    }

    static var benchpress: [Workout.Exercise] {
        [
            Workout.Exercise(
                exercise: "Benchpress",
                set: 1,
                weight: 12.5,
                reps: 8
            ),
            Workout.Exercise(
                exercise: "Benchpress",
                set: 2,
                weight: 12.5,
                reps: 7
            ),
            Workout.Exercise(
                exercise: "Benchpress",
                set: 3,
                weight: 10.0,
                reps: 8
            )
        ]
    }

    static var legpress: [Workout.Exercise] {
        [
            Workout.Exercise(
                exercise: "Legpress",
                set: 1,
                weight: 120.0,
                reps: 9
            ),
            Workout.Exercise(
                exercise: "Legpress",
                set: 2,
                weight: 120.0,
                reps: 9
            ),
            Workout.Exercise(
                exercise: "Legpress",
                set: 3,
                weight: 100.0,
                reps: 8
            )
        ]
    }
}
