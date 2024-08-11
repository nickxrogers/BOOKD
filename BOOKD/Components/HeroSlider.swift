//
//  HeroSlider.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/8/24.
//

import SwiftUI
import Foundation
import FluidGradient

struct HeroSlider: View {
    
    var colors: [Color]
    var highlights: [Color]
    var avgColor: Color

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("The Livin' Room".uppercased())
                        .font(.custom("InterTight-ExtraBold", size: 20))
                    Text("Popular".uppercased())
                        .font(.custom("InterTight-Regular", size: 14))
                        .foregroundColor(Color(UIColor.secondaryLabel))
                }
                Spacer()
            }
            .padding(.top)
            .padding(.horizontal)
            Image("livinroom")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
        }
        .containerRelativeFrame(.horizontal)
        .background {
            FluidGradient(
                blobs: colors,
                highlights: highlights,
                speed: 0.2
            )
            .saturation(1.5)
            .overlay(.ultraThinMaterial)
        }
        .cornerRadius(14)
        .shadow(radius: 8)
    }
}
