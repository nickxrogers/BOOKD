//
//  OnboardingFour.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/10/24.
//

import SwiftUI
import FluidGradient
import Foundation
import ColorKit
import PhotosUI
import SwiftyCrop


struct OnboardingFour: View {
    
    @State var dominantColors: [Color] = [.clear]
    @State var generatedPalette: [Color] = [.clear]
    @State var averageColor: Color = .clear
    @State var textColor: Color = .clear
    @State private var selectedPhotos: [PhotosPickerItem] = [] // To store selected photos
    @State private var selectedImage: UIImage? = nil // To store the UIImage
    @State private var bio: String = ""
    @State private var showAge = true
    @State private var showMyLocation = true
    
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
        NavigationStack {
            VStack {
                ZStack {
                    ZStack {
                        VStack {
                            if let selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .containerRelativeFrame(.horizontal)
                                    .frame(height: 300)
                                    .clipped()
                                    .onAppear{
                                        getColors(image: UIImage(named: "togo")!)
                                    }
                            } else {
                                Color.gray
                                    .frame(height: 300)
                            }
                        }    .onChange(of: selectedPhotos) { newItems in
                            guard let item = newItems.first else { return }
                            
                            item.loadTransferable(type: Data.self) { result in
                                switch result {
                                case .success(let data):
                                    if let data, let uiImage = UIImage(data: data) {
                                        selectedImage = uiImage // Save UIImage to memory
                                    }
                                case .failure(let error):
                                    print("Error loading image data: \(error)")
                                }
                            }
                        }
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
                            PhotosPicker(
                                selection: $selectedPhotos,
                                maxSelectionCount: 1, // Set the number of images user can select
                                matching: .images // Only show images (not videos)
                            ) {
                                Text("Upload".uppercased())
                                    .font(.custom("InterTight-Bold", size: 12))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                    .background {
                                        if averageColor == .clear {
                                            Color.black
                                        }
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            
                        }
                        .shadow(radius: 8)
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }
                    .frame(height: 300)
                    
                    .ignoresSafeArea()
                    
                }
                .frame(height: 300)
                
                
                VStack {
                    HStack {
                        Text("Bio".uppercased()).font(.custom("InterTight-Bold", size: 18))
                        Spacer()
                    }.padding()
                    TextEditor(text: $bio)
                        .scrollContentBackground(.hidden)
                        .frame(height: 90) // Set the desired height
                        .padding(.horizontal)
                        .background(.sheetbg)
                    
                }
                .background(Color.sheetbg) // Background color
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1) // Optional border
                )
                .padding()
                
                    
                    Toggle(isOn: $showAge) {
                        Text("Show my age\non my profile".uppercased())
                            .font(.custom("InterTight-Regular", size: 16))
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                Toggle(isOn: $showMyLocation) {
                    Text("Show my Location\non my profile".uppercased())
                        .font(.custom("InterTight-Regular", size: 16))
                }
               .padding(.horizontal)
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: OnboardingThree()) {
                        CircularButton()
                            .shadow(radius: 8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    OnboardingFour()
}
