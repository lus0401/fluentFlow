//
//  CustomButton.swift
//  fluentFlow
//
//  Created by Lee HyeKyung on 5/17/24.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var backgroundColor: Color = .blue
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .cornerRadius(15.0)
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "Sample Button", action: {
            print("Button tapped")
        })
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
