//
//  ColorSaturationBG.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/9/24.
//

import SwiftUI
import FluidGradient

struct ColorSaturationBG: View {
    
    var blobs: [Color]
    var highlights: [Color] = [.clear]
    var speed: CGFloat = 1
    var blur: CGFloat = 0.75
    var background: Color = .clear
    var material: bgElement = .regularMaterial
    var overlay: Bool = true
    var saturation: CGFloat = 1
    
    var body: some View {
        FluidGradient(
            blobs: blobs,
            highlights: highlights,
            speed: speed,
            blur: blur)
        .saturation(saturation)
        .background(background)
        .overlay {
            if overlay {
                overlayView(for: material)
            } else {
                EmptyView()
            }
        }
    }
}

@ViewBuilder
func overlayView(for material: bgElement) -> some View {
    switch material {
    case .ultraThinMaterial:
        Color.clear.background(.ultraThinMaterial)
    case .thinMaterial:
        Color.clear.background(.thinMaterial)
    case .regularMaterial:
        Color.clear.background(.regularMaterial)
    case .thickMaterial:
        Color.clear.background(.thickMaterial)
    case .ultraThickMaterial:
        Color.clear.background(.ultraThickMaterial)
    }
}

#Preview {
    ColorSaturationBG(blobs: [.red, .blue, .purple])
}
