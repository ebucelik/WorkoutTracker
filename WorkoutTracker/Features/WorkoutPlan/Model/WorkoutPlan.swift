//
//  WorkoutPlan.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 20.01.24.
//

import Foundation

struct WorkoutPlan: Codable, Hashable {
    struct Exercise: Codable, Hashable {
        var name: String
        var sets: Int
        var weight: Float
        var reps: Int

        init(name: String, sets: Int, weight: Float, reps: Int) {
            self.name = name
            self.sets = sets
            self.weight = weight
            self.reps = reps
        }
    }

    var username: String
    var workoutplanname: String
    var exercises: [Exercise]

    init(username: String, workoutplanname: String, exercises: [Exercise]) {
        self.username = username
        self.workoutplanname = workoutplanname
        self.exercises = exercises
    }
}

extension WorkoutPlan {
    static var empty: WorkoutPlan {
        WorkoutPlan(
            username: "",
            workoutplanname: "",
            exercises: [
                .empty
            ]
        )
    }

    func toWorkoutExercises() -> [Workout.Exercise] {
        var workouts = [Workout.Exercise]()

        for exercise in self.exercises {
            for set in 0..<exercise.sets {
                workouts.append(
                    Workout.Exercise(
                        exercise: exercise.name,
                        set: set + 1,
                        weight: exercise.weight,
                        reps: exercise.reps
                    )
                )
            }
        }

        return workouts
    }

    func toWorkout() -> Workout {
        Workout(
            username: nil,
            workoutname: self.workoutplanname,
            workoutdate: "",
            workouts: self.toWorkoutExercises()
        )
    }
}

extension WorkoutPlan.Exercise {
    static var empty: WorkoutPlan.Exercise {
        WorkoutPlan.Exercise(
            name: "",
            sets: 0,
            weight: 0.0,
            reps: 0
        )
    }
}
