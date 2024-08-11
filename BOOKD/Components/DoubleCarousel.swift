//
//  DoubleCarousel.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/8/24.
//

import SwiftUI

struct DoubleCarousel<Content: View>: View {
    let content: () -> Content
    let itemCount: Int
    let spacing: CGFloat

    init(itemCount: Int, spacing: CGFloat = 10, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.itemCount = itemCount
        self.spacing = spacing
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: spacing) {
                ForEach(1...itemCount, id: \.self) { _ in
                    content()
                        .padding(.vertical)
                }
            }
            .scrollTargetLayout()
        }
        .safeAreaPadding(.horizontal)
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    DoubleCarousel(itemCount: 5) {
        GigCardSlim(image: UIImage(named: "aaron")!)
    }
}
