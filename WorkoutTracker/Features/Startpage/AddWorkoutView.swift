//
//  AddWorkoutView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 19.01.24.
//

import SwiftUI

struct AddWorkoutView: View {

    let workouts: [Workout] = .workouts

    @State
    var selectedWorkoutPlan: Workout = .empty

    var body: some View {
        VStack {
            Text("Choose a plan")
                .font(.largeTitle)

            Picker("", selection: $selectedWorkoutPlan) {
                ForEach(workouts, id: \.self) { workout in
                    Text(workout.workoutname)
                        .tag(workout)
                }
            }
            .pickerStyle(.segmented)
            .padding(4)

            Spacer()

            if selectedWorkoutPlan != .empty {
                WorkoutDetailView(
                    workout: $selectedWorkoutPlan,
                    isAddPlanView: true
                )
            }
        }
    }
}

#Preview {
    AddWorkoutView()
}
