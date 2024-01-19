//
//  WeightsView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 16.01.24.
//

import SwiftUI

struct WeightsView: View {

    @State
    var weights: [Weight] = .weights
    @State
    var newWeight: Weight = .empty
    @State
    var selectedDate: Date = Date.now

    var weightFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        return formatter
    }

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }

    var body: some View {
        VStack {
            Text("Weights")
                .font(.largeTitle)

            List(Array(weights.enumerated()), id: \.offset) { weight in
                HStack {
                    Text(String(format: "%.1f", weight.element.weight))

                    Text("kg")

                    Spacer()

                    Text(weight.element.date)

                    Button {
                        // TODO: delete Call
                        weights.remove(at: weight.offset)
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.red)
                            .padding(.leading)
                    }
                }
            }
            .listStyle(.plain)

            HStack {
                VStack {
                    TextField(
                        "Add weight e.g. 78.2",
                        value: $newWeight.weight,
                        formatter: weightFormatter
                    )
                    .frame(maxWidth: 50)
                    .multilineTextAlignment(.center)
                }
                .padding(8)
                .background(.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerSize: .init(width: 8, height: 8)))

                Text("kg")
            }
            .padding(.horizontal, 24)

            DatePicker(
                "",
                selection: $selectedDate,
                displayedComponents: .date
            )
            .labelsHidden()

            Button {
                // TODO: add call
                if newWeight.weight > 0 {
                    newWeight.date = dateFormatter.string(from: selectedDate)
                    weights.append(newWeight)

                    newWeight = .empty
                    selectedDate = .now
                }
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .padding()

            Spacer()
        }
        .onTapGesture {
            Common.shared.hideKeyboard()
        }
    }
}

#Preview {
    WeightsView()
}
