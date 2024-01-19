//
//  WorkoutPlanDetailView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 19.01.24.
//

import SwiftUI

struct WorkoutPlanDetailView: View {

    @Environment(\.dismiss)
    var dismiss

    @EnvironmentObject
    var account: Account

    @State
    var workout: Workout

    var body: some View {
        ScrollView {
            VStack {
                Text("Create a workout plan")
                    .font(.largeTitle)

                Spacer()
                    .frame(height: 25)

                TextField("Add workout name", text: $workout.workoutname)

                Divider()

                Spacer()
                    .frame(height: 25)

                if !workout.workouts.isEmpty {
                    ForEach(Array(workout.workouts.enumerated()), id: \.offset) { exercise in
                        VStack {
                            HStack {
                                VStack {
                                    Text("\(exercise.offset + 1). Exercise")
                                        .font(.headline)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.bottom, 16)

                                    Text("Add exercise name")
                                        .font(.subheadline)
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                    VStack {
                                        TextField("Exercise e.g. Benchpress", text: $workout.workouts[exercise.offset].exercise)
                                    }
                                    .padding(8)
                                    .background(.gray.opacity(0.3))
                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 4, height: 4)))
                                    .padding(.bottom, 12)

                                    Text("Add set")
                                        .font(.subheadline)
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                    VStack {
                                        TextField(
                                            "Set e.g. 3",
                                            value: $workout.workouts[exercise.offset].set,
                                            formatter: NumberFormatter()
                                        )
                                    }
                                    .padding(8)
                                    .background(.gray.opacity(0.3))
                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 4, height: 4)))
                                }

                                Button {
                                    workout.workouts.remove(at: exercise.offset)
                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundStyle(.red)
                                }
                            }
                        }
                        .padding(.vertical, 16)
                    }

                    Spacer()
                        .frame(height: 50)
                }

                Button {
                    workout.workouts.append(Workout.Exercise.empty)
                } label: {
                    Text("Add new exercise")
                }

                if !workout.workoutname.isEmpty,
                   !workout.workouts.isEmpty,
                   workout.workouts.allSatisfy({ $0.set > 0 && !$0.exercise.isEmpty }) {
                    Spacer()
                        .frame(height: 25)

                    Button {
                        // TODO: save workout plan call
                        dismiss()
                    } label: {
                        Text("Save workout plan")
                    }
                }

                Spacer()
            }
            .padding()
            .onTapGesture {
                Common.shared.hideKeyboard()
            }
        }
    }
}
