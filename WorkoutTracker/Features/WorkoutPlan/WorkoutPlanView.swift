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
    var workouts: [Workout] = []

    var body: some View {
        ZStack {
            VStack {
                Text("Workout Plans")
                    .font(.largeTitle)

                Spacer()

                List(workouts, id: \.self) { workoutplan in
                    NavigationLink {
                        WorkoutPlanDetailView(workout: workoutplan)
                    } label: {
                        Text(workoutplan.workoutname)
                    }
                }
                .listStyle(.plain)
            }
            .navigationDestination(
                isPresented: $showWorkoutPlanDetailView
            ) {
                WorkoutPlanDetailView(workout: .empty)
            }

            VStack {
                HStack {
                    Spacer()

                    Button {
                        showWorkoutPlanDetailView.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .onAppear {
            // TODO: get call for plans
        }
    }
}

#Preview {
    WorkoutPlanView()
}
