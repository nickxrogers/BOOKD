//
//  OnboardingThree.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/10/24.
//

import SwiftUI

struct OnboardingThree: View {
    
    @State var name: String = ""
    @State private var selectedDate = Date()
    @State private var showPicker = false
    @State private var closeButtonPressed = false
    @State private var selectedContainer: Int? = nil
    @State private var dimMale = false
    @State private var dimFemale = false
    @State private var artist = false
    @State private var management = false
    @State private var nonBinary = false
    @State private var dimNon = false
    @State private var non = false
    @State private var animateNonButton = false
    @State private var blurAmount: CGFloat = 20
    @State private var blurAmountTwo: CGFloat = 20

    
    // Function to calculate container width
        private func getContainerWidth(screenHeight: CGFloat, selected: Bool) -> CGFloat {
            let totalPadding: CGFloat = 16 * 3 // Padding between containers and at the edges
            let availableHeight = screenHeight - totalPadding
            
            if let _ = selectedContainer {
                return selected ? availableHeight * 0.75 : availableHeight * 0.25
            } else {
                return availableHeight / 2
            }
        }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("What type of account \ndo you want to make?")
                    .font(.custom("InterTight-Bold", size: 32))
                    .padding(.horizontal)
                    .padding(.vertical)
                GeometryReader { geometry in
                    VStack(spacing: 16) {
                        
                        VStack(spacing: 16) {
                            Image(systemName: "figure.stand")
                                .font(selectedContainer == 1 ? .system(size: 50) : .largeTitle)
                            
                            if selectedContainer == 1 {
                                VStack {
                                    Text("You want to sign up\nas an artist".uppercased())
                                    
                                        .font(.custom("InterTight-Bold", size: 14))
                                        .multilineTextAlignment(.center)
                                    NavigationLink(destination: OnboardingFour()) {
                                        Text("Continue".uppercased())
                                            .font(.custom("InterTight-Bold", size: 14))
                                            .padding(.horizontal)
                                            .padding(.vertical, 8)
                                            .background(.ultraThinMaterial)
                                            .clipShape(Capsule())
                                    }
                                    .buttonStyle(.plain)
                                        
                                }
                                .blur(radius: selectedContainer == 1 ? blurAmount : 0) // Apply the blur
                                .onAppear {
                                    withAnimation(.easeOut(duration: 0.7)) {
                                        blurAmount = 0 // Animate to remove blur
                                    }
                                }
                            }
                            
                        }
                        
                        .frame(width: geometry.size.width - 32)
                        .frame(height: self.getContainerWidth(screenHeight: geometry.size.height, selected: selectedContainer == 1))
                        .background(
                            ColorSaturationBG(
                                blobs: [ArtistPalette.columbiaBlue, ArtistPalette.bittersweet, ArtistPalette.prussianBlue],
                                highlights: [ArtistPalette.fireEngineRed, ArtistPalette.teal],
                                speed: 0.4,
                                saturation: selectedContainer == 1 ? 4 : 1
                            )
                        )
                        
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .opacity(dimMale ? 0.6 : 1)
                        .shadow(color: Color.black.opacity(0.2),radius: 10)
                        .onTapGesture {
                            withAnimation {
                                selectedContainer = selectedContainer == 1 ? nil : 1
                                non = false
                                
                            }
                        }
                        .scaleEffect(artist ? 1.05 : 1.0)
                        .opacity(artist ? 0.6 : 1.0)
                        .pressEvents {
                            // On press
                            withAnimation(.easeInOut(duration: 0.1)) {
                                artist = true
                            }
                        } onRelease: {
                            withAnimation {
                                artist = false
                            }
                        }
                        VStack(spacing: 16) {
                            if selectedContainer == 2 {
                                VStack {
                                    Text("You want to sign up\nas management".uppercased())
                                    
                                        .font(.custom("InterTight-Bold", size: 14))
                                        .multilineTextAlignment(.center)
                                }
                                .blur(radius: selectedContainer == 2 ? blurAmountTwo : 0) // Apply the blur
                                .onAppear {
                                    withAnimation(.easeOut(duration: 0.7)) {
                                        blurAmountTwo = 0 // Animate to remove blur
                                    }
                                }
                            }
                            Image(systemName: "briefcase.fill")
                                .font(selectedContainer == 2 ? .system(size: 50) : .largeTitle)
                        }
                        
                        .frame(height: self.getContainerWidth(screenHeight: geometry.size.height, selected: selectedContainer == 2))
                        .frame(width: geometry.size.width - 32)
                        .background(
                            ColorSaturationBG(
                                blobs: [ManagmentPalette.verdigris, ManagmentPalette.emerald],
                                highlights: [ManagmentPalette.lightGreen, ManagmentPalette.teaGreen],
                                speed: 0.4,
                                saturation: selectedContainer == 2 ? 4 : 1
                            )
                        )
                        
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .opacity(dimFemale ? 0.6 : 1)
                        .shadow(color: Color.black.opacity(0.2),radius: 10)
                        .onTapGesture {
                            withAnimation {
                                selectedContainer = selectedContainer == 2 ? nil : 2
                                non = false
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }

        
       
    }
}

struct ManagmentPalette {
    static let lapisLazuli = Color(hex: "22577a")
    static let verdigris = Color(hex: "38a3a5")
    static let emerald = Color(hex: "57cc99")
    static let lightGreen = Color(hex: "80ed99")
    static let teaGreen = Color(hex: "c7f9cc")
}

struct ArtistPalette {
    static let prussianBlue = Color(hex: "0b3954")
    static let teal = Color(hex: "087e8b")
    static let columbiaBlue = Color(hex: "bfd7ea")
    static let bittersweet = Color(hex: "ff5a5f")
    static let fireEngineRed = Color(hex: "c81d25")
}

#Preview {
    OnboardingThree()
}
