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

    var body: some View {
        VStack {
            Text("Workouts")
                .font(.largeTitle)

            List(workouts, id: \.self) { workout in
                VStack(alignment: .leading) {
                    NavigationLink {
                        WorkoutDetailView(workout: workout)
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
    }
}

#Preview {
    WorkoutsView()
}
