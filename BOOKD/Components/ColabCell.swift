//
//  ColabCell.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/8/24.
//

import SwiftUI
import FluidGradient
import Foundation
import Combine


struct ColabCell: View {
    
    var height: CGFloat
    var leftBlobs: [Color]
    var rightBlobs: [Color]
    var leftHighlights: [Color]
    var rightHighlights: [Color]
    var leftBg: Color
    var rightBg: Color
    var colab: Colab
    
    var body: some View {
                HStack {
                    VStack {
                        colab.imageOne
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                            .shadow(radius: 8)
                    }
                    Spacer()
                    VStack {
                        Text(colab.title)
                            .font(.custom("InterTight-Bold", size: 16))
                        Text("Atay and Ebo".uppercased()).font(.custom("InterTight-Light", size: 12))
                            .padding(.bottom, 8)
                        HStack {
                            Image (systemName: "music.note").font(.system(size: 14))
                            Text("3:16").font(.custom("InterTight-Regular", size: 14))
                        }
                        HStack {
                            Text("Listen".uppercased()).font(.custom("InterTight-SemiBold", size: 12))
                            Image(systemName: "chevron.right").font(.system(size: 12))
                        }.padding(.horizontal)
                            .padding(.vertical, 4)
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .shadow(color: Color.black.opacity(0.1), radius: 6)
                    }
                    Spacer()
                    VStack {
                        colab.imageTwo
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                            .shadow(radius: 8)
                    }
                }
                
                .frame(height: height)
                .padding(.horizontal)
                .background {
                    ZStack {
                        FluidGradient(blobs: leftBlobs, highlights: leftHighlights, speed: 0.1).background(leftBg)
                            .frame(height: height)
                            .mask(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .leading, endPoint: .trailing))
                        FluidGradient(blobs: rightBlobs, highlights: rightHighlights, speed: 0.1)
                            .background(rightBg)
                            .frame(height: height)
                            .mask(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .trailing, endPoint: .leading))
                        Rectangle().fill(.regularMaterial).frame(height: height)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 6)
            
    }
}
