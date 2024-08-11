//
//  Profile.swift
//  BOOKD
//
//  Created by Nick Rogers on 7/31/24.
//

import SwiftUI
import ColorKit
import FluidGradient

struct Profile: View {
    
    @State var dominantColors: [Color] = [.clear]
    @State var generatedPalette: [Color] = [.clear]
    @State var averageColor: Color = .clear
    @State var textColor: Color = .clear
    @ObservedObject var socialMediaData = SocialMediaData()
    @State private var scrollOffset: CGFloat = 0
    
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
                withAnimation(.spring()) {
                    updateTextColor()
                }
                
                
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
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                ZStack {
                    ZStack {
                        VStack {
                            Image("togo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .containerRelativeFrame(.horizontal)
                                .frame(height: 300)
                                .clipped()
                                .onAppear{
                                    getColors(image: UIImage(named: "togo")!)
                                }
                            Spacer()
                        }
                        .ignoresSafeArea()
                        BannerOverlay(
                            dominantColors: dominantColors,
                            generatedPalette: generatedPalette,
                            averageColor: averageColor,
                            textColor: textColor
                        )
                        .mask(
                            LinearGradient(
                                gradient: Gradient(
                                            colors: [Color.black, Color.black, Color.black.opacity(0), Color.black.opacity(0), Color.black.opacity(0)]
                                            ),
                                            startPoint: .bottom,
                                            endPoint: .top
                            )
                        )
                    }
                    .ignoresSafeArea()
                    VStack {
                        Spacer()
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("CASSI B")
                                    .font(.custom("InterTight-Black", size: 28))
                                    .foregroundStyle(textColor)
                                Text("@CASSIB")
                                    .font(.custom("InterTight-Light", size: 14))
                                    .foregroundStyle(textColor)
                            }
                            Spacer()
                            Button {
                                    
                            } label: {
                                Text("FOLLOW")
                                    .font(.custom("InterTight-Bold", size: 12))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                    .background(averageColor)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                        }
                        .shadow(radius: 8)
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }
                    .frame(height: 300)
                    }
                    
                VStack {
                    HStack {
                        Text("Mutual Friends".uppercased())
                            .font(.custom("InterTight-Bold", size: 12))
                        Spacer()
                    }
                        .padding(.top)
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            UserCardSlim(
                                image: UIImage(named: "nick")!,
                                name: "XN",
                                city: "Houston"
                            )
                            UserCardSlim(
                                image: UIImage(named: "aaron")!,
                                name: "ATAY",
                                city: "Houston"
                            )
                            UserCardSlim(
                                image: UIImage(named: "ebo")!,
                                name: "EBO",
                                city: "San Antonio"
                            )
                        }
                    }
                        .safeAreaPadding(.all)
                }
                
                HStack {
                    Spacer()
                    VStack(spacing: 16) {
                        Text("4.2k")
                            .font(.custom("InterTight-Regular", size: 24))
                        Divider().frame(width: 50)
                        Text("Followers".uppercased())
                            .font(.custom("InterTight-Bold", size: 10))
                    }
                    Spacer()
                        VStack(spacing: 16) {
                            Text("800")
                                .font(.custom("InterTight-Regular", size: 24))
                            Divider().frame(width: 50)
                            Text("Following".uppercased())
                                .font(.custom("InterTight-Bold", size: 10))
                    }
                    Spacer()
                    VStack(spacing: 16) {
                        Text("345")
                            .font(.custom("InterTight-Regular", size: 24))
                        Divider().frame(width: 50)
                        Text("Posts".uppercased())
                            .font(.custom("InterTight-Bold", size: 10))
                    }
                    Spacer()
                }
                    .frame(height: 100)
                    .padding(.all)
                    .background(Color.sheetbg)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .padding(.all)
                
                HStack {
                    Text("Posts".uppercased())
                        .font(.custom("InterTight-ExtraBold", size: 20))
                    Spacer()
                }
                .padding(.bottom)
                .padding(.horizontal)
                
                ForEach(socialMediaData.posts) { post in
                    ProfilePostItem(user: post.username, text: post.content)
                        .padding(.bottom)
                }
                
                Spacer()
                
                }
                    .ignoresSafeArea()
            }
                .ignoresSafeArea()

            
    }
}

#Preview {
    Profile()
}

struct BannerOverlay: View {
    
    var dominantColors: [Color] = [.clear]
    var generatedPalette: [Color] = [.clear]
    var averageColor: Color = .clear
    var textColor: Color = .white
    
    var body: some View {
        FluidGradient(
            blobs: dominantColors,
            highlights: generatedPalette,
            speed: 0.1
        )
        .background(averageColor)
        .containerRelativeFrame(.horizontal)
        .frame(height: 300)
    }
}

struct UserCardSlim: View {
    
    @State private var dominantColors: [Color] = [.clear]
    @State private var generatedPalette: [Color] = [.clear]
    @State private var averageColor: Color = .clear
    @State private var textColor: Color = .white
    
    var image: UIImage
    var name: String
    var city: String

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
                print("success")
            } catch {
            print("Error extracting colors: \(error)")
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 100)
                .onAppear {
                    getColors(image: image)
                }
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.custom("InterTight-SemiBold", size: 14))
                HStack(spacing: 5) {
                    Image(systemName: "location.fill")
                        .font(.system(size: 10))
                        .foregroundStyle(.secondary)
                    Text(city.uppercased())
                        .font(.custom("InterTight-Regular", size: 12))
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical)
            
        }
        .containerRelativeFrame(.horizontal, count: 3, spacing: 10)
            .background {
                FluidGradient(
                    blobs: dominantColors,
                    highlights: generatedPalette,
                    speed: 0
                )
                .saturation(1.5)
                .overlay(.thinMaterial)
            }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(radius: 8)
    }
}

struct ProfilePostItem: View {
    
    var user: String
    var text: String
    
    func fontSize(for text: String, in size: CGSize) -> CGFloat {
          let characterCount = text.count
          let baseFontSize: CGFloat = 16 // Regular body size
          let maxFontSize: CGFloat = 24 // Maximum font size for short text

          // Adjust font size based on the text length
          if characterCount < 50 {
              return maxFontSize
          } else if characterCount < 100 {
              return baseFontSize + (maxFontSize - baseFontSize) * CGFloat(100 - characterCount) / 50
          } else {
              return baseFontSize
          }
      }
    
    var body: some View {
            VStack(alignment: .leading) {
                HStack(spacing: 16) {
                
                    Image("togo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.uppercased())
                            .font(.custom("InterTight-Bold", size: 14))
                        Text("@\(user)")
                            .font(.custom("InterTight-Light", size: 10))
                    }
                    Spacer()
                    Image(systemName: "ellipsis")
                }
                .padding(.horizontal)
                
                GeometryReader { geometry in
                                    Text(text)
                                        .font(.custom("InterTight-Regular", size: fontSize(for: text, in: geometry.size)))
                                        .padding(.horizontal)
                                }
                                .frame(height: 100)
            }
            .padding(.vertical)
            .background(.sheetbg)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding(.horizontal)
    }
}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
