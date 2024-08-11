//
//  GigCardSlim.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/8/24.
//


import SwiftUI
import Foundation
import FluidGradient
import ColorKit
import Firebase

struct GigCardSlim: View {
    
    private var dominantColors: [Color] = [.clear]
    private var generatedPalette: [Color] = [.clear]
    private var averageColor: Color = .clear
    private var textColor: Color = .white
    
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
        extractColors(image: image)
    }
    
    private mutating func extractColors(image: UIImage) {
         do {
             let colors = try image.dominantColors()
             dominantColors = colors.map { Color($0) }
             
             if let palette = ColorPalette(orderedColors: colors, ignoreContrastRatio: true) {
                 generatedPalette = [palette.background, palette.primary].compactMap { Color($0) }
                 if let secondary = palette.secondary {
                     generatedPalette.append(Color(secondary))
                 }
             }
             
             let avgColor = try image.averageColor()
             averageColor = Color(avgColor)
             print("success")
          
         } catch {
             print("Error extracting colors: \(error)")
         }
     }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("ATAY's\nSoul Room").font(.custom("InterTight-Bold", size: 16))
                    Text("Dec. 28th").font(.custom("InterTight-Regular", size: 14))
                    Spacer().frame(height: 20)
                }
                Spacer()
                Image("aaron")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            }.padding()
            Divider()
            HStack {
                Image(systemName: "music.mic")
                    .font(.system(size: 14))
                    .frame(width: 24, height: 24)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                Text("Vocalist".uppercased())
                    .font(.custom("InterTight-Bold", size: 12))
            }
            .padding(.top)
            .padding(.leading)
            HStack(alignment: .center) {
                Image(systemName: "parkingsign")
                    .font(.system(size: 10))
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 24, height: 24)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                Text("Validated\nParking".uppercased())
                    .font(.custom("InterTight-Bold", size: 12))
            }
            .padding(.top, 8)
            .padding(.leading)
            HStack(alignment: .center) {
                Image(systemName: "bolt")
                    .font(.system(size: 10))
                    .bold()
                    .foregroundColor(.black)
                    .frame(width: 24, height: 24)
                    .background(.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                Text("Instant Pay".uppercased())
                    .font(.custom("InterTight-Bold", size: 12))
            }
            .padding(.top, 8)
            .padding(.leading)
            
        }
        .padding(.bottom, 8)
        .containerRelativeFrame(.horizontal, count: 2, spacing: 10)
            .background {
                FluidGradient(
                    blobs: generatedPalette,
                    highlights: dominantColors,
                    speed: 0
                )
                .saturation(1.5)
                .overlay(.regularMaterial)
            }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 6)
    }
}
