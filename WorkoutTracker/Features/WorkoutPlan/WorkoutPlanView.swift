//
//  WorkoutPlanView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 19.01.24.
//

import SwiftUI

struct WorkoutPlanView: View {

    @State
    var showWorkoutPlanDetailView: Bool = false

    @State
    var workoutPlans: [WorkoutPlan] = []
    @State
    var message: Message?

    @EnvironmentObject
    var account: Account

    let workoutPlanService = WorkoutPlanService()

    var body: some View {
        ZStack {
            VStack {
                Text("Workout Plans")
                    .font(.largeTitle)

                Spacer()

                List(workoutPlans, id: \.self) { workoutplan in
                    NavigationLink {
                        WorkoutPlanDetailView(workoutPlan: workoutplan)
                    } label: {
                        Text(workoutplan.workoutplanname)
                    }
                }
                .listStyle(.plain)
            }

            if let message {
                Common.shared.messageView(message: message)
            }

            VStack {
                HStack {
                    Spacer()

                    NavigationLink {
                        WorkoutPlanDetailView(workoutPlan: .empty)
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
    WorkoutPlanView()
}
