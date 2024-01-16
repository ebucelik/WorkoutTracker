//
//  SideMenuContentView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 16.01.24.
//

import SwiftUI

struct SideMenuContentView: View {

    @Binding
    var selectedRow: Int
    @Binding
    var presentSideMenu: Bool

    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .fill(.white)
                    .frame(width: 270)
                    .shadow(
                        color: .blue.opacity(0.1),
                        radius: 5,
                        x: 0,
                        y: 3
                    )

                VStack(alignment: .leading, spacing: 0) {
                    ForEach(SideMenuRowType.allCases, id: \.self) { row in
                        rowView(
                            isSelected: selectedRow == row.rawValue,
                            title: row.title
                        ) {
                            selectedRow = row.rawValue
                            presentSideMenu.toggle()
                        }
                    }

                    Spacer()
                }
                .padding(.top, 100)
                .frame(width: 270)
                .background(.white)
            }

            Spacer()
        }
        .background(.clear)
    }

    @ViewBuilder
    func rowView(
        isSelected: Bool,
        title: String,
        hideDivider: Bool = false,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
        } label: {
            VStack(alignment: .leading) {
                HStack(spacing: 20) {
                    Rectangle()
                        .fill(isSelected ? .blue : .white)
                        .frame(width: 5)

                    Text(title)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(isSelected ? .black : .gray)

                    Spacer()
                }
            }
        }
        .frame(height: 30)
    }
}
