//
//  Home.swift
//  BOOKD
//
//  Created by Nick Rogers on 7/31/24.
//

import Foundation
import SwiftUI
import FluidGradient
import ColorKit
import Alamofire
import SDWebImageSwiftUI
import BottomSheet
import FirebaseFunctions



struct Home: View {
    @State var searchText = ""
    @State private var offset: CGFloat = 0
    @State var isPresented = false
    @State var selectedDetent: BottomSheet.PresentationDetent = .medium
    @StateObject var settings = SheetSettings()
    @State private var gradientOpacity: Double = 0.0
    @FocusState private var isTextFieldFocused: Bool
    @State private var searchFieldPadding: CGFloat = 8 // Add this line
    @State private var searchFieldHPadding: CGFloat = 20 // Add this line
    @State private var topPadding: CGFloat = 8
    @State private var promptSize: CGFloat = 12
    @State var dominantColors: [Color] = [.clear]
    @State var generatedPalette: [Color] = [.clear]
    @State var averageColor: Color = .clear
    @State var textColor: Color = .white
    @StateObject var venueStore = SampleVenuesList()

    private func opacity(for translation: CGFloat) -> CGFloat {
        let minTranslation: CGFloat = 800
        let maxTranslation: CGFloat = 890
        let maxOpacity: CGFloat = 1.0

        if translation >= maxTranslation {
            return 0
        } else if translation <= minTranslation {
            return maxOpacity
        } else {
            let normalizedTranslation = (translation - minTranslation) / (maxTranslation - minTranslation)
            return maxOpacity - normalizedTranslation
        }
    }
    
    private func hideKeyboard() {
         UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
     }
    
    func getColors(image: UIImage) {
        DispatchQueue.global(qos: .background).async {
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
            updateTextColor()
            print("success")
            
        } catch {
            print("Error extracting colors: \(error)")
        }
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

    
    let colabDictionary: [Colab] = [
        Colab(id: UUID().uuidString, title: "BROKEN", artistOne: "XN", artistTwo: "ATAY", imageOne: Image("nick"), imageTwo: Image("aaron"), duration: "3:16"),
        Colab(id: UUID().uuidString, title: "In My Bag", artistOne: "EBO", artistTwo: "ATAY", imageOne: Image("ebo"), imageTwo: Image("aaron"), duration: "3:29")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 0.0) {
                    VStack {
                        SearchField(
                            searchText: searchText,
                            isTextFieldFocused: _isTextFieldFocused,
                            searchFieldTopPadding: $searchFieldPadding,
                            searchFieldHPadding: $searchFieldHPadding,
                            topPadding: $topPadding,
                            prompt: "What do you want to see?",
                            promptSize: promptSize
                        )
                            .opacity(opacity(for: settings.translation))
                            .onChange(of: isTextFieldFocused) { focused in
                                withAnimation {
                                    gradientOpacity = focused ? 1.0 : 0.0
                                    searchFieldPadding = focused ? 20 : 10
                                    searchFieldHPadding = focused ? 8 : 20
                                    topPadding = focused ? 20 : 16
                                    promptSize = focused ? 14 : 12
                                }
                            }
                        VStack(spacing: 10) {
                            HeroView(
                                itemCount: 5,
                                dominantColors: dominantColors,
                                generatedPalette: generatedPalette,
                                averageColor: averageColor,
                                imageName: "livinroom",
                                onAppearAction: {
                                    getColors(image: UIImage(named: "livinroom")!)
                                   
                                }
                            )
                            
                            FeedHeaderRow(
                                text: "Suggested",
                                size: 18,
                                padding: false,
                                trailing: {
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.primary)
                                        .padding(.horizontal)
                                }
                            )
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(venueStore.venues) { venue in
                                        SquareVenueTile(venue: venue)
                                        
                                    }
                                }
                                .scrollTargetLayout()
                            }
                            .scrollTargetBehavior(.viewAligned)
                            .safeAreaPadding()
                            
                        VStack(spacing: 0) {
                            
                            FeedHeaderRow(
                                text: "Colabs",
                                size: 18,
                                padding: false,
                                trailing: {
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.primary)
                                        .padding(.horizontal)
                                }
                            )
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 10) {
                                    ForEach(colabDictionary) { colab in
                                        ColabCell(
                                            height: 120,
                                            leftBlobs: [.red, .pink, .purple],
                                            rightBlobs: [.green, .teal, .blue],
                                            leftHighlights: [.white, .blue, .red.opacity(0.5)],
                                            rightHighlights: [.green, .green.opacity(0.5)],
                                            leftBg: .red,
                                            rightBg: .green,
                                            colab: colab
                                        )
                                            .scrollTransition(axis: .horizontal) { content, phase in
                                                content
                                                    .opacity(phase.isIdentity ? 1 : 0)
                                                    .blur(radius: phase.isIdentity ? 0 : 10)
                                            }
                                            .containerRelativeFrame(.horizontal)
                                    }
                                }
                                    .frame(height: 140)
                                    .scrollTargetLayout()
                            }
                                .safeAreaPadding(.horizontal)
                                .scrollTargetBehavior(.viewAligned)
                            }
                            VStack {
                                FeedHeaderRow(
                                    text: "Recent",
                                    size: 18,
                                    padding: false,
                                    trailing: {
                                    
                                    }
                                )

                                DoubleCarousel(itemCount: 5) {
                                        GigCardSlim(image: UIImage(named: "aaron")!)
                                }
                            }
                }
                        .offset(y: -8)
                    Spacer()
                    }
                    Spacer().frame(height: 200)
                }
                .ignoresSafeArea()
                .onTapGesture {
                    hideKeyboard()
                }
            }
            .background {
                VStack {
                    FluidGradient(blobs: [.red, .pink, .purple], highlights: [.red, .white])
                        .mask(LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom))
                        .frame(height: 200)
                        .ignoresSafeArea()
                        .opacity(gradientOpacity)
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        NavigationLink(destination: OnboardingOne()) {
                            Text("BOOKD").font(.custom("BarlowCondensed-ExtraBold", size: 32))
                        }
                        .buttonStyle(.plain)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: Profile()) {
                        Image("album")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .shadow(radius: 10).padding(.bottom, 8)
                    }
                }
            }
        }
    }
}

#Preview {
    Home()
}











struct SquareVenueTile: View {
    
    var venue: VenueInfo
    
    @State var dominantColors: [Color] = [.clear]
    @State var generatedPalette: [Color] = [.clear]
    @State var averageColor: Color = .clear
    @State var textColor: Color = .white
    
    func getColors(image: UIImage) {
        DispatchQueue.global(qos: .background).async {
        do {
            let colors = try image.dominantColors(with: .low)
            dominantColors = colors.map { Color($0) }
            
            if let palette = ColorPalette(orderedColors: colors, ignoreContrastRatio: true) {
                generatedPalette = [palette.background, palette.primary].compactMap { Color($0) }
                if let secondary = palette.secondary {
                    generatedPalette.append(Color(secondary))
                }
            }
            
            let avgColor = try image.averageColor()
            averageColor = Color(avgColor)
            updateTextColor()
            print("success")
            
        } catch {
            print("Error extracting colors: \(error)")
        }
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
    
    var body: some View {
        ZStack {
            WebImage(url: URL(string: venue.imageUrl))
                .onSuccess { image, data, cacheType in
                               // This closure is called when the image is successfully loaded.
                    getColors(image: image)
                           }
                .resizable()
                .aspectRatio(contentMode: .fill)
      
            VStack {
                Spacer(minLength: 0)
                HStack {
                    VStack(alignment: .leading) {
                        Text(venue.name)
                            .font(.custom("InterTight-SemiBold", size: 16))
                            .foregroundStyle(textColor)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        Text(venue.city.uppercased())
                            .font(.custom("InterTight-Regular", size: 12))
                            .foregroundStyle(textColor.opacity(0.6))
                    }
                    Spacer(minLength: 0)
                }
                .padding(.bottom, 10)
                .padding(.horizontal, 10)
                .containerRelativeFrame(.horizontal, count: 2, spacing: 10)
                .frame(height: 70)
                .background {
                    FluidGradient(
                        blobs: generatedPalette,
                        highlights: dominantColors,
                        speed: 0.1
                        )
                    .saturation(1.2)
                    .background(averageColor)
                    .background(.thickMaterial)
                }
            }
        }
        .containerRelativeFrame(.horizontal, count: 2, spacing: 10)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
