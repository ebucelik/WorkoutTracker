//
//  SideMenuRowType.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 16.01.24.
//

import Foundation

enum SideMenuRowType: Int, CaseIterable {
    case workout = 0
    case weight = 1
    case visual = 2

    var title: String {
        switch self {
        case .workout:
            return "Workouts"
        case .weight:
            return "Weights"
        case .visual:
            return "Visual Progress"
        }
    }
}
