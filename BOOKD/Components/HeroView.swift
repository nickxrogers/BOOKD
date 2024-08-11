//
//  HeroView.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/8/24.
//

import SwiftUI

struct HeroView: View {
    let itemCount: Int
    let dominantColors: [Color]
    let generatedPalette: [Color]
    let averageColor: Color
    let imageName: String
    let onAppearAction: () -> Void

    init(
        itemCount: Int = 5,
        dominantColors: [Color],
        generatedPalette: [Color],
        averageColor: Color,
        imageName: String,
        onAppearAction: @escaping () -> Void
    ) {
        self.itemCount = itemCount
        self.dominantColors = dominantColors
        self.generatedPalette = generatedPalette
        self.averageColor = averageColor
        self.imageName = imageName
        self.onAppearAction = onAppearAction
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(1...itemCount, id: \.self) { _ in
                    HeroSlider(
                        colors: dominantColors,
                        highlights: generatedPalette,
                        avgColor: averageColor
                    )
                    .scrollTransition(axis: .horizontal) { content, phase in
                        content
                            .opacity(phase.isIdentity ? 1 : 0)
                            .blur(radius: phase.isIdentity ? 0 : 10)
                    }
                    .onAppear {
                        onAppearAction()
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .safeAreaPadding()
    }
}


