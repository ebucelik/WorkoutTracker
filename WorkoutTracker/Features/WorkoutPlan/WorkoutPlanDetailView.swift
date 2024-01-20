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
    var workoutPlan: WorkoutPlan
    @State
    var message: Message?

    let workoutPlanService = WorkoutPlanService()

    var body: some View {
        ScrollView {
            VStack {
                Text("Create a workout plan")
                    .font(.largeTitle)

                Spacer()
                    .frame(height: 25)

                if let message {
                    Common.shared.messageView(message: message)
                }

                TextField("Add workout name", text: $workoutPlan.workoutplanname)

                Divider()

                Spacer()
                    .frame(height: 25)

                if !workoutPlan.exercises.isEmpty {
                    ForEach(Array(workoutPlan.exercises.enumerated()), id: \.offset) { exercise in
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
                                        TextField("Exercise e.g. Benchpress", text: $workoutPlan.exercises[exercise.offset].name)
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
                                            value: $workoutPlan.exercises[exercise.offset].sets,
                                            formatter: NumberFormatter()
                                        )
                                    }
                                    .padding(8)
                                    .background(.gray.opacity(0.3))
                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 4, height: 4)))
                                }

                                Button {
                                    workoutPlan.exercises.remove(at: exercise.offset)
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
                    workoutPlan.exercises.append(WorkoutPlan.Exercise.empty)
                } label: {
                    Text("Add new exercise")
                }

                if !workoutPlan.workoutplanname.isEmpty,
                   !workoutPlan.exercises.isEmpty,
                   workoutPlan.exercises.allSatisfy({ $0.sets > 0 && !$0.name.isEmpty }) {
                    Spacer()
                        .frame(height: 25)

                    Button {
                        Task {
                            do {
                                message = nil

                                workoutPlan.username = account.username

                                _ = try await workoutPlanService.addWorkoutPlan(workoutPlan)

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
