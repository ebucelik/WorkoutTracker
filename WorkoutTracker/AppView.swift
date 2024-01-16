//
//  AppView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 15.01.24.
//

import SwiftUI

struct AppView: View {

    @State
    var presentSideMenu: Bool = false
    @State
    var selectedRow = 0
    @State
    var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                TabView(selection: $selectedRow) {
                    WorkoutsView()
                        .tabItem {
                            Label(
                                title: { Text("Workouts") },
                                icon: { Image(systemName: "dumbbell.fill") }
                            )
                        }
                        .tag(0)

                    Text("Workoutplan") // TODO: replace
                        .tabItem {
                            Label(
                                title: { Text("Workoutplan") },
                                icon: { Image(systemName: "list.bullet.clipboard.fill") }
                            )
                        }

                    Text("Music") // TODO: replace
                        .tabItem {
                            Label(
                                title: { Text("Music") },
                                icon: { Image(systemName: "music.note") }
                            )
                        }
                }

                VStack {
                    HStack {
                        Button {
                            presentSideMenu.toggle()
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .resizable()
                                .frame(width: 24, height: 16)
                        }

                        Spacer()
                    }

                    Spacer()
                }
                .padding(.horizontal, 24)

                SideMenuView(
                    isPresenting: $presentSideMenu,
                    content: AnyView(
                        SideMenuContentView(
                            selectedRow: $selectedRow,
                            presentSideMenu: $presentSideMenu
                        )
                    )
                )
            }
            .onChange(of: selectedRow) {
                if selectedRow == 1 {
                    path.append(selectedRow)
                }

                if selectedRow == 2 {
                    path.append(selectedRow)
                }
            }
            .navigationDestination(for: Int.self) { selection in
                if selection == 1 {
                    WeightsView()
                }

                if selection == 2 {
                    VisualProgressView()
                }
            }
        }
    }
}

#Preview {
    AppView()
}
