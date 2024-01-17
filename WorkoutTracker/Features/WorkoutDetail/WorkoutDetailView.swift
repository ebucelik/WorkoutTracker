//
//  WorkoutDetailView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 17.01.24.
//

import SwiftUI

struct WorkoutDetailView: View {

    let workout: Workout

    var body: some View {
        VStack {
            Text(workout.workoutname)
                .font(.largeTitle)
        }
    }
}

#Preview {
    WorkoutDetailView(workout: .mock)
}
