//
//  WorkoutsView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 16.01.24.
//

import SwiftUI

struct WorkoutsView: View {

    @State
    var workouts: [Workout] = .workouts
    @State
    var showAddWorkoutView = false

    var body: some View {
        ZStack {
            VStack {
                Text("Workouts")
                    .font(.largeTitle)

                List(workouts, id: \.self) { workout in
                    VStack(alignment: .leading) {
                        NavigationLink {
                            WorkoutDetailView(
                                workout: .constant(workout),
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
        }
    }
}

#Preview {
    WorkoutsView()
}
