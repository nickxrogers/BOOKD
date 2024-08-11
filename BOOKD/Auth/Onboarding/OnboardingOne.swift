//
//  OnboardingOne.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/9/24.
//

import SwiftUI
import CoreLocation
import FluidGradient

struct OnboardingOne: View {
    
    @State var name: String = ""
    @State private var selectedDate = Date()
    @State private var showPicker = false
    @State private var closeButtonPressed = false
    @State private var selectedContainer: Int? = nil
    @State private var dimMale = false
    @State private var dimFemale = false
    @State private var male = false
    @State private var female = false
    @State private var nonBinary = false
    @State private var dimNon = false
    @State private var non = false
    @State private var animateNonButton = false


    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    HStack(spacing: 10) {
                        Image(systemName: "person.circle.fill")
                            .font(.largeTitle)
                        Text("You")
                            .font(.custom("InterTight-ExtraBold", size: 32))
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 120)
                    Spacer().frame(height: 10)
                    VStack(alignment: .leading, spacing: 20) {
                        Text("We just need a few details about you".uppercased())
                            .font(.custom("Intertight-SemiBold", size: 14))
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                        BookdTextField(
                            text: $name,
                            prompt: "Name",
                            type: .name,
                            vPadding: 16,
                            fontSize: 16
                        )
                        GeometryReader { geo in
                            let availableWidth = geo.size.width - 36
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Date of\nBirth").font(.custom("InterTight-SemiBold", size: 32))
                                }
                                Spacer()
                                Text(selectedDate.formatted(date: .numeric, time: .omitted))
                                    .font(.custom("Intertight-Regular", size: 24))
                                    .frame(width: availableWidth / 2,height: 90)
                                    .background(.sheetbg)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .onTapGesture {
                                        withAnimation {
                                            showPicker.toggle()
                                        }
                                    }
                            }.padding(.horizontal)
                        }
                        .frame(height: 90)
                        
                        GeometryReader { geometry in
                            HStack(spacing: 16) {
                                Image(systemName: "figure")
                                    .font(non ? .title3 : .largeTitle)
                                    .frame(height: non ? 35 : 70)
                                    .frame(width: self.getContainerWidth(screenWidth: geometry.size.width, selected: selectedContainer == 1))
                                    .background(
                                        ColorSaturationBG(
                                            blobs: [.blue, .cyan, .white],
                                            highlights: [.blue, .white],
                                            saturation: selectedContainer == 1 ? 4 : 2
                                            
                                        )
                                    )
                                
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .opacity(dimMale ? 0.6 : 1)
                                    .shadow(color: Color.black.opacity(0.2),radius: 15)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedContainer = selectedContainer == 1 ? nil : 1
                                            non = false
                                            
                                        }
                                    }
                                    .scaleEffect(male ? 1.05 : 1.0)
                                    .opacity(male ? 0.6 : 1.0)
                                    .pressEvents {
                                        // On press
                                        withAnimation(.easeInOut(duration: 0.1)) {
                                            male = true
                                        }
                                    } onRelease: {
                                        withAnimation {
                                            male = false
                                        }
                                    }
                                Image(systemName: "figure")
                                    .font(non ? .title3 : .largeTitle)
                                    .frame(height: non ? 35 : 70)
                                    .frame(width: self.getContainerWidth(screenWidth: geometry.size.width, selected: selectedContainer == 2))
                                
                                    .background(ColorSaturationBG(blobs: [.pink, .red, .purple]))
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                
                                    .scaleEffect(female ? 1.05 : 1.0)
                                    .opacity(female ? 0.6 : 1.0)
                                    .shadow(color: Color.black.opacity(0.2),radius: 15)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedContainer = selectedContainer == 2 ? nil : 2
                                            non = false
                                        }
                                    }
                                    .pressEvents {
                                        // On press
                                        withAnimation(.easeInOut(duration: 0.1)) {
                                            female = true
                                        }
                                    } onRelease: {
                                        withAnimation {
                                            female = false
                                        }
                                    }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: non ? 35 : 70)
                        GradientButton(
                            action: {
                                withAnimation {
                                    non.toggle()
                                    male = false
                                    female = false
                                    selectedContainer = nil
                                }
                            },
                            label: "non-binary".uppercased(),
                            colors: [.yellow, .white, .gray],
                            height: non ? 70 : 50,
                            textSize: non ? 16 : 14,
                            saturation: non ? 4 : 2,
                            background: .yellow
                        )
                        .opacity(dimNon ? 0.6 : 1)
                        .shadow(color: Color.black.opacity(0.2),radius: 10)
                        .scaleEffect(animateNonButton ? 1.05 : 1.0)
                        .opacity(animateNonButton ? 0.6 : 1.0)
                        .pressEvents {
                            // On press
                            withAnimation(.easeInOut(duration: 0.1)) {
                                animateNonButton = true
                            }
                        } onRelease: {
                            withAnimation {
                                animateNonButton = false
                            }
                        }
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: OnboardingTwo()) {
                                CircularButton()
                                    .shadow(color: Color.black.opacity(0.2),radius: 10)
                        }.buttonStyle(.plain)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
                if showPicker {
                    ZStack {
                        PlayerBlurView()
                            .ignoresSafeArea()
                            .transition(.blurReplace())
                        VStack(spacing: 16) {
                            Text("Select Your Birthday".uppercased())
                                .font(.custom("InterTight-Bold", size: 20))
                            
                            DatePicker(
                                "Select a date",
                                selection: $selectedDate,
                                in: ...Date(),
                                displayedComponents: .date
                            )
                            .datePickerStyle(GraphicalDatePickerStyle())
                            // or .wheel, .compact, etc.
                            .padding()
                            
                            Button {
                                withAnimation {
                                    showPicker.toggle()
                                }
                            }
                            label: {
                                Text("Done".uppercased())
                                    .font(.custom("InterTight-SemiBold", size: 16))
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 100)
                                    .background(.regularMaterial)
                                    .clipShape(Capsule())
                                    .scaleEffect(closeButtonPressed ? 1.05 : 1.0)
                                    .opacity(closeButtonPressed ? 0.6 : 1.0)
                                    .pressEvents {
                                        // On press
                                        withAnimation(.easeInOut(duration: 0.1)) {
                                            closeButtonPressed = true
                                        }
                                    } onRelease: {
                                        withAnimation {
                                            closeButtonPressed = false
                                        }
                                    }
                            }
                                .buttonStyle(.plain)
                        }
                            .transition(.blurReplace())
                    }
                        .ignoresSafeArea()
                }
            }
                
                .accentColor(.primary)
        }
    }
    // Function to calculate container width
        private func getContainerWidth(screenWidth: CGFloat, selected: Bool) -> CGFloat {
            let totalPadding: CGFloat = 16 * 3 // Padding between containers and at the edges
            let availableWidth = screenWidth - totalPadding
            
            if let _ = selectedContainer {
                return selected ? availableWidth * 0.75 : availableWidth * 0.25
            } else {
                return availableWidth / 2
            }
        }
}

#Preview {
    OnboardingOne()
}

struct CircularButton: View {
    @State private var isPressed = false
    var body: some View {
        ZStack {
            ColorSaturationBG(
                blobs: [.blue, ArtistPalette.columbiaBlue],
                highlights: [ArtistPalette.prussianBlue, .white],
                speed: 0.1,
                material: .ultraThinMaterial,
                saturation: 3
            )
            .frame(width: 70, height: 70)
            .clipShape(Circle())
            Image(systemName: "arrow.right")
                .font(.title)
                .opacity(0.9)
        }
        .scaleEffect(isPressed ? 1.05 : 1.0)
        .opacity(isPressed ? 0.6 : 1.0)
        .pressEvents {
            // On press
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
        } onRelease: {
            withAnimation {
                isPressed = false
            }
        }
    }
}


  
       
