//
//  MapSheet.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/6/24.
//

import SwiftUI
import FluidGradient
import SDWebImageSwiftUI
import ColorKit


struct BGImageView: View {
    var venue: VenueInfo
    @Binding var dominantColors: [Color]
    @Binding var averageColor: Color
    @Binding var textColor: Color
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                ZStack(alignment: .top) {
                    WebImage(url: URL(string: venue.bannerUrl))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxHeight: 250)
                        .clipped()
                    HStack {
                        Spacer()
                        Text((venue.city.uppercased()))
                            .font(.custom("InterTight-SemiBold", size: 14))
                            .foregroundStyle(textColor)
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                            .background(averageColor)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .shadow(radius: 6)
                            .padding(.top, 8)
                    }.padding(.horizontal)
                }
                
                Spacer().frame(height: 80)
            }
            .overlay {
                FluidGradient(
                    blobs: dominantColors,
                    speed: 0.2
                )
                .saturation(1.7)
                .background(averageColor.opacity(0.6))
                .overlay(.ultraThinMaterial)
                .mask(
                    LinearGradient(colors: [.black, .black, .gray, .clear, .clear, .clear], startPoint: .bottom, endPoint: .top)
                )
            }
            // Info Overlay
            GeometryReader { geo in
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                    Text(venue.name)
                        .font(.custom("InterTight-ExtraBold", size: fontSize(for: venue.name, in: geo.size, min: 16, max: 36)))
                        .foregroundStyle(textColor)
                        .frame(width: UIScreen.main.bounds.width * 0.75, alignment: .leading)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 8)
                        .shadow(radius: 6)
                    // Address
                    VStack(spacing: 0) {
                        VStack {
                            HStack(alignment: .top) {
                                Image(systemName: "mappin.and.ellipse")
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(venue.address)
                                        .font(.custom("InterTight-SemiBold", size: 16))
                                    Text(venue.city.uppercased())
                                        .font(.custom("InterTight-Regular", size: 14))
                                }
                                Spacer()
                            }
                        }
                        .padding(.vertical)
                        .frame(height: 80)
                        .background(.regularMaterial)
                    }
                    .safeAreaPadding(.horizontal, 8)
                }
                .frame(height: 280)
                .safeAreaPadding(.horizontal)
            }
            .frame(height: 280)
        }
        
    }
    
    private func fontSize(for text: String, in size: CGSize, min: CGFloat, max: CGFloat) -> CGFloat {
        let characterCount = text.count
        let baseFontSize: CGFloat = min
        let maxFontSize: CGFloat = max
        
        if characterCount < 50 {
            return maxFontSize
        } else if characterCount < 100 {
            return baseFontSize + (maxFontSize - baseFontSize) * CGFloat(100 - characterCount) / 50
        } else {
            return baseFontSize
        }
    }
}



    

class MapSheetViewModel: ObservableObject {
    @Published var dominantColors: [Color] = [.clear]
    @Published var generatedPalette: [Color] = [.clear]
    @Published var averageColor: Color = .clear
    @Published var textColor: Color = .white
    
    private var hasColorsBeenExtracted: Bool = false
    
    func getColors(image: UIImage) {
        guard !hasColorsBeenExtracted else { return }
        hasColorsBeenExtracted = true
        
        DispatchQueue.global(qos: .background).async {
            do {
                let colors = try image.dominantColors(with: .low)
                let avgColor = try image.averageColor()

                DispatchQueue.main.async {
                    self.dominantColors = colors.map { Color($0) }
                    
                    if let palette = ColorPalette(orderedColors: colors, ignoreContrastRatio: true) {
                        self.generatedPalette = [palette.background, palette.primary].compactMap { Color($0) }
                        if let secondary = palette.secondary {
                            self.generatedPalette.append(Color(secondary))
                        }
                    }
                    
                    self.averageColor = Color(avgColor)
                    self.updateTextColor()
                }
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
        textColor = luminanceValue > 0.6 ? .black : .white
    }
}

struct ExpandingSheet: View {
    
    
    @Binding var expand: Bool
    
    var height = UIScreen.main.bounds.height / 3
    var safeArea = UIApplication.shared.windows.first?.safeAreaInsets
    @State var volume: CGFloat = 0
    @State var offset: CGFloat = 0
    @StateObject var venueStore = SampleVenuesList()
    var venue: VenueInfo
    
    @StateObject var viewModel = MapSheetViewModel()
    
    private func fontSize(for text: String, in size: CGSize, min: CGFloat, max: CGFloat) -> CGFloat {
        let characterCount = text.count
        let baseFontSize: CGFloat = min
        let maxFontSize: CGFloat = max
        
        if characterCount < 50 {
            return maxFontSize
        } else if characterCount < 100 {
            return baseFontSize + (maxFontSize - baseFontSize) * CGFloat(100 - characterCount) / 50
        } else {
            return baseFontSize
        }
    }
    
    var body: some View {
        VStack {
            if expand {
                Spacer(minLength: 0)
            }
            VStack {
                VStack(spacing: 15) {
                    ZStack(alignment: .top) {
                        BGImageView(
                            venue: venue,
                            dominantColors: $viewModel.dominantColors,
                            averageColor: $viewModel.averageColor,
                            textColor: $viewModel.textColor
                        )
                        .clipShape(TopRoundedShape(cornerRadius: 20))
                        .onAppear {
                            // Fetch image and extract colors
                            if let url = URL(string: venue.bannerUrl) {
                                SDWebImageManager.shared.loadImage(
                                    with: url,
                                    options: .highPriority,
                                    progress: nil
                                ) { image, _, _, _, _, _ in
                                    if let image = image {
                                        viewModel.getColors(image: image)
                                    }
                                }
                            }
                        }
                        HStack {
                            Spacer()
                            Capsule()
                                .fill(.gray)
                                .frame(width: 60, height: 4)
                                .opacity(expand ? 1 : 0)
                                .padding(.top, expand ? safeArea?.top : 0)
                                .padding(.vertical, expand ? 30 : 0)
                            Spacer()
                        }
                    }.frame(height: 280)
                }
                if expand {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(1...4, id: \.self) { item in
                                GeometryReader { geo in
                                    VStack(alignment: .leading, spacing: 10) {
                                        HStack(alignment: .top) {
                                            Text("3rd Ward Block Party")
                                                .font(.custom("InterTight-Bold", size: fontSize(for: venue.name, in: geo.size, min: 14, max: 28)))
                                                .foregroundStyle(viewModel.textColor)
                                                .frame(width: UIScreen.main.bounds.width * 0.5, alignment: .leading)
                                                .lineLimit(2)
                                                .multilineTextAlignment(.leading)
                                            
                                            Spacer()
                                            
                                            VStack {
                                                Text("18th")
                                                    .font(.custom("Intertight-Regular", size: 28))
                                                Text("AUB")
                                                    .font(.custom("InterTight-ExtraBold", size: 14))
                                            }
                                        }
                                        
                                        HStack {
                                            Text("View Details".uppercased())
                                                .font(.custom("InterTight-Bold", size: 14))
                                                .padding(.vertical, 10)
                                                .padding(.horizontal)
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .padding(.horizontal)
                                        }
                                        .background(.regularMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                    }
                                    
                                    .padding()
                                    .background(viewModel.averageColor)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .padding(.vertical)
                                }
                                
                                .frame(height: 120)
                                .padding(.horizontal)
                                .padding(.vertical)
                            }
                        }
                        
                        .frame(height: expand ? nil : 0)
                        .opacity(expand ? 1 : 0)
                    }
                }
            }
            .frame(maxHeight: expand ? .infinity : 60)
            .background {
                VStack(spacing: 0) {
                    PlayerBlurView()
                    Divider()
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        expand = true
                    }
                }
                
            }
            .onTapGesture {
                withAnimation(.spring()) {
                    expand = true
                }
            }
    
            .offset(y: offset)
            .gesture(DragGesture().onEnded(onEnded(value:)).onChanged(onChanged(value:)))
            .ignoresSafeArea()
        }
        .padding(.top, expand ? safeArea?.top : 0)
        .padding(.bottom, expand ? 0 : safeArea?.bottom)
        .frame(height: expand ? UIScreen.main.bounds.height * 0.8 : 300)
    }
    func onChanged(value: DragGesture.Value) {
        if value.translation.height > 0 && expand {
            offset = value.translation.height
        }
    }
    func onEnded(value: DragGesture.Value) {
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.95)) {
            if value.translation.height > height {
                expand = false
            }
            offset = 0
        }
    }
}

struct ExpandingSheet_Previews: PreviewProvider {
    @Namespace static var animation

    static var previews: some View {
        Group {
            // Collapsed Preview
            ExpandingSheet(
                expand: .constant(false),
                venue: SampleVenuesList().venues.randomElement()!
            )
            .previewDisplayName("Collapsed State")
            
            // Expanded Preview
            ExpandingSheet(

                expand: .constant(true),
                venue: SampleVenuesList().venues.randomElement()!
            )
            .previewDisplayName("Expanded State")
        }
    }
}
