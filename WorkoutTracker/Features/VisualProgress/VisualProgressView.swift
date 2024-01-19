//
//  VisualProgressView.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 16.01.24.
//

import SwiftUI
import UIKit

struct VisualProgressView: View {

    @State
    var openCamera = false
    @State
    var selectedImage: UIImage?

    var body: some View {
        VStack {
            Text("Visual Progress")
                .font(.largeTitle)

            Spacer()

            Button {
                openCamera.toggle()
            } label: {
                if let selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .frame(width: 300, height: 300)
                } else {
                    Text("Add picture")
                }
            }

            Spacer()
        }
        .sheet(
            isPresented: $openCamera
        ) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
}

#Preview {
    VisualProgressView()
}
