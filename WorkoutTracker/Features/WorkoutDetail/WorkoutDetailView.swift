//
//  WorkoutDetailView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 17.01.24.
//

import SwiftUI

struct WorkoutDetailView: View {

    @State
    var workout: Workout

    @Environment(\.dismiss)
    var dismiss

    var weightFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        return formatter
    }

    var body: some View {
        VStack {
            Text(workout.workoutname)
                .font(.largeTitle)

            List(Array(workout.workouts.enumerated()), id: \.offset) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.element.exercise)
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Set: ")

                            Text("\(exercise.element.set)")
                        }

                        HStack {
                            Text("Weight: ")

                            TextField(
                                "",
                                value: $workout.workouts[exercise.offset].weight,
                                formatter: weightFormatter
                            )

                            Text("kg")
                        }

                        HStack {
                            Text("Reps: ")

                            TextField(
                                "",
                                value: $workout.workouts[exercise.offset].reps,
                                formatter: NumberFormatter()
                            )
                        }
                    }
                    .padding()
                }
            }
            .listStyle(.plain)

            Button(
                action: {
                    // TODO: save plan
                    dismiss()
                },
                label: {
                    Text("Update \(workout.workoutname)")
                        .font(.title2)
                }
            )
            .padding(.vertical, 8)
        }
    }
}

#Preview {
    WorkoutDetailView(workout: .mock)
}
