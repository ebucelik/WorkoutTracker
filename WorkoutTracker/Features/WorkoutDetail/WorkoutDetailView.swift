//
//  WorkoutDetailView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 17.01.24.
//

import SwiftUI

struct WorkoutDetailView: View {

    @State
    var message: Message?

    @State
    var workout: Workout = .empty

    @Binding
    var tempWorkout: Workout

    var isAddPlanView: Bool

    @Environment(\.dismiss)
    var dismiss

    @EnvironmentObject
    var account: Account

    let workoutService = WorkoutService()

    var weightFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        return formatter
    }

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }

    var body: some View {
        VStack {
            Text(workout.workoutname)
                .font(.largeTitle)

            if let message {
                Common.shared.messageView(message: message)
            }

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
                    Task {
                        do {
                            message = nil

                            workout.username = account.username
                            workout.workoutdate = dateFormatter.string(from: Date.now)

                            _ = try await workoutService.addWorkout(with: workout)

                            dismiss()
                        } catch {
                            if let error = error as? APIError {
                                switch error {
                                case .unauthorized(let message), .unknown(let message):
                                    self.message = message
                                default:
                                    break
                                }
                            }
                        }
                    }
                },
                label: {
                    if isAddPlanView {
                        Text("Add plan")
                            .font(.title2)
                    } else {
                        Text("Update \(workout.workoutname)")
                            .font(.title2)
                    }
                }
            )
            .padding(.vertical, 8)
        }
        .onTapGesture {
            Common.shared.hideKeyboard()
        }
        .onAppear {
            self.workout = tempWorkout
        }
        .onChange(of: tempWorkout) { _, newValue in
            self.workout = newValue
        }
    }
}
