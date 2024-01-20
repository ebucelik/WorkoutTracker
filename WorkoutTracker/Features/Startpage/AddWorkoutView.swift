//
//  AddWorkoutView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 19.01.24.
//

import SwiftUI

struct AddWorkoutView: View {

    @State
    var workoutPlans: [WorkoutPlan] = []
    @State
    var selectedWorkoutPlan: WorkoutPlan = .empty
    @State
    var message: Message?

    @EnvironmentObject
    var account: Account

    let workoutPlanService = WorkoutPlanService()

    var body: some View {
        VStack {
            Text("Choose a plan")
                .font(.largeTitle)

            if let message {
                Common.shared.messageView(message: message)
            }

            Picker("", selection: $selectedWorkoutPlan) {
                ForEach(workoutPlans, id: \.self) { workout in
                    Text(workout.workoutplanname)
                        .tag(workout)
                }
            }
            .pickerStyle(.segmented)
            .padding(4)

            Spacer()

            if selectedWorkoutPlan != .empty {
                WorkoutDetailView(
                    tempWorkout: .constant($selectedWorkoutPlan.wrappedValue.toWorkout()),
                    isAddPlanView: true
                )
            }
        }
        .onAppear {
            Task {
                do {
                    message = nil

                    self.workoutPlans = try await workoutPlanService.getWorkoutPlans(by: account.username)
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
        }
    }
}

#Preview {
    AddWorkoutView()
}
