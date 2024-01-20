//
//  WeightsView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 16.01.24.
//

import SwiftUI

struct WeightsView: View {

    @State
    var weights: Weights = Weights(weights: [])
    @State
    var newWeight: Weight = .empty
    @State
    var selectedDate: Date = Date.now
    @State
    var message: Message?

    @EnvironmentObject
    var account: Account

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

    let weightService = WeightService()

    var body: some View {
        VStack {
            Text("Weights")
                .font(.largeTitle)

            if let message {
                Common.shared.messageView(message: message)
            }

            List(Array(weights.weights.enumerated()), id: \.offset) { weight in
                HStack {
                    Text(String(format: "%.1f", weight.element.weight))

                    Text("kg")

                    Spacer()

                    Text(weight.element.date)

                    Button {
                        // TODO: delete Call
                        weights.weights.remove(at: weight.offset)
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
                if newWeight.weight > 0 {
                    newWeight.username = account.username
                    newWeight.date = dateFormatter.string(from: selectedDate)

                    Task {
                        do {
                            message = nil

                            let weight = try await weightService.addWeight(newWeight)

                            weights.weights.append(weight)

                            newWeight = .empty
                            selectedDate = .now
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
        .onAppear {
            Task {
                do {
                    message = nil

                    self.weights = try await weightService.getWeights(by: account.username)
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
    WeightsView()
}
