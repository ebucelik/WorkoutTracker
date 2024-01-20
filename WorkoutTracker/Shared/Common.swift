//
//  Common.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 17.01.24.
//

import UIKit
import SwiftUI

public class Common {

    public static let shared = Common()

    fileprivate init() {}

    public func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }

    public func messageView(message: Message) -> some View {
        HStack {
            Text(message.message)
                .font(.caption)
                .foregroundStyle(.white)
                .padding()
        }
        .background(.red)
        .clipShape(RoundedRectangle(cornerSize: .init(width: 8, height: 8)))
        .padding(.bottom)
    }
}
