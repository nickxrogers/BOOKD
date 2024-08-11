//
//  GradientButton.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/9/24.
//

import SwiftUI

struct GradientButton: View {
    
    var action: () -> Void
    var label: String
    @State private var isPressed = false
    var colors: [Color] = [.red, .blue, .purple]
    var maxWidth: CGFloat = .infinity
    var height: CGFloat = 50
    var textSize: CGFloat = 14
    var saturation: CGFloat = 1
    var background: Color = .clear
    
    var body: some View {
        Button {
           action()
        }
        label: {    Text(label.uppercased())
                .font(.custom("InterTight-Bold", size: textSize))
                .foregroundStyle(Color("black"))
                .padding(.vertical, 16)
                .frame(maxWidth: maxWidth)
                .frame(height: height)
                .padding(.horizontal)
                .background {
                    ColorSaturationBG(
                        blobs: colors,
                        speed: 0.4,
                        background: background,
                        saturation: saturation
                    )
                }
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .scaleEffect(isPressed ? 1.05 : 1.0)
                .opacity(isPressed ? 0.6 : 1.0)
                .pressEvents {
                    // On press
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed = true
                    }
                } onRelease: {
                    withAnimation {
                        isPressed = false
                    }
                }
                .padding(.horizontal)
        }
    }
}

#Preview {
    GradientButton(action: {print("success")}, label: "Button")
}
