//
//  WorkoutsView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 16.01.24.
//

import SwiftUI

struct WorkoutsView: View {

    @State
    var workouts: [Workout] = []
    @State
    var showAddWorkoutView = false
    @State
    var message: Message?

    @EnvironmentObject
    var account: Account

    let workoutService = WorkoutService()

    var body: some View {
        ZStack {
            VStack {
                Text("Workouts")
                    .font(.largeTitle)

                if let message {
                    Common.shared.messageView(message: message)
                }

                List(workouts, id: \.self) { workout in
                    VStack(alignment: .leading) {
                        NavigationLink {
                            WorkoutDetailView(
                                tempWorkout: .constant(workout),
                                isAddPlanView: false
                            )
                        } label: {
                            HStack {
                                Text(workout.workoutname)

                                Spacer()

                                Text(workout.workoutdate)
                            }
                        }

                    }
                }
                .listStyle(.plain)
            }

            VStack {
                HStack {
                    Spacer()

                    NavigationLink {
                        AddWorkoutView()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
        .onAppear {
            Task {
                do {
                    message = nil

                    self.workouts = try await workoutService.getWorkouts(by: account.username)
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
    WorkoutsView()
}
