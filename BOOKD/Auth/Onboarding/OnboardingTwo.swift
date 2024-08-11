//
//  OnboardingTwo.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/10/24.
//

import SwiftUI
import FluidGradient
import Firebase


struct OnboardingTwo: View {
    
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
                    .padding(.vertical, 60)
                    Spacer().frame(height: 10)
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Choose your Username".uppercased())
                            .font(.custom("Intertight-SemiBold", size: 14))
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                        BookdTextField(
                            text: $name,
                            prompt: "Username",
                            type: .name,
                            vPadding: 10,
                            fontSize: 16,
                            leadingText: "@"
                        )
                        
                        
                    }
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
  
            }
            .accentColor(.primary)
        }
    }
}

#Preview {
    OnboardingTwo()
}
