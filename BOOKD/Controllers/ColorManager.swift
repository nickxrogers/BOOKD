//
//  ColorManager.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/3/24.
//

import Foundation
import SwiftUI
import ColorKit

class BackgroundColors: ObservableObject {
    @Published  var dominantColors: [Color] = [.clear]
    @Published  var generatedPalette: [Color] = [.clear]
    @Published  var averageColor: Color = .clear
}

class MapSheetColors: ObservableObject {
    @Published var dominantColors: [Color] = [.clear]
    @Published var generatedPalette: [Color] = [.clear]
    @Published var averageColor: Color = .clear
    @Published var textColor: Color = .clear
}

class SongItem: ObservableObject {
  @Published var image: UIImage
  @Published var dominantColors: [Color] = [.clear]
  @Published var generatedPalette: [Color] = [.clear]
  @Published var averageColor: Color = .clear
  @Published var textColor: Color = .white
    @State var artistName: String = ""

  init(image: UIImage) {
    self.image = image
    extractColors(from: image)
  }

    func extractColors(from image: UIImage) {
         do {
             let colors = try image.dominantColors()
             BackgroundColors().dominantColors = colors.map { Color($0) }
             
             if let palette = ColorPalette(orderedColors: colors, ignoreContrastRatio: true) {
                 generatedPalette = [palette.background, palette.primary].compactMap { Color($0) }
                 if let secondary = palette.secondary {
                     generatedPalette.append(Color(secondary))
                 }
             }
             
             let avgColor = try image.averageColor()
             BackgroundColors().averageColor = Color(avgColor)
             updateTextColor()
          
         } catch {
             print("Error extracting colors: \(error)")
         }
     }
    
    func luminance(of color: UIColor) -> CGFloat {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return 0.299 * red + 0.587 * green + 0.114 * blue
    }

    
    func updateTextColor() {
        let uiColor = UIColor(averageColor)
        let luminanceValue = luminance(of: uiColor)
        textColor = luminanceValue > 0.5 ? .black : .white
    }
    
}

class ColorExtractor: ObservableObject {
  @Published var image: UIImage
  @Published var dominantColors: [Color] = [.clear]
  @Published var generatedPalette: [Color] = [.clear]
  @Published var averageColor: Color = .clear
  @Published var textColor: Color = .white
    @State var artistName: String = ""

  init(image: UIImage) {
    self.image = image
    extractColors()
  }

    private func extractColors() {
         do {
             let colors = try image.dominantColors()
             BackgroundColors().dominantColors = colors.map { Color($0) }
             
             if let palette = ColorPalette(orderedColors: colors, ignoreContrastRatio: true) {
                 BackgroundColors().generatedPalette = [palette.background, palette.primary].compactMap { Color($0) }
                 if let secondary = palette.secondary {
                     BackgroundColors().generatedPalette.append(Color(secondary))
                 }
             }
             
             let avgColor = try image.averageColor()
             BackgroundColors().averageColor = Color(avgColor)
             updateTextColor()
             print("success")
          
         } catch {
             print("Error extracting colors: \(error)")
         }
     }
    
    private func luminance(of color: UIColor) -> CGFloat {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return 0.299 * red + 0.587 * green + 0.114 * blue
    }

    
    private func updateTextColor() {
        let uiColor = UIColor(averageColor)
        let luminanceValue = luminance(of: uiColor)
        textColor = luminanceValue > 0.5 ? .black : .white
    }
}

