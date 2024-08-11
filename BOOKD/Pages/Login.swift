//
//  Login.swift
//  BOOKD
//
//  Created by Nick Rogers on 7/31/24.
//

//
//  LoginScreen.swift
//  MyProject
//
//  Designed in DetailsPro
//  Copyright © (My Organization). All rights reserved.
//

import SwiftUI

struct LoginScreen: View {
    
    @State private var phone: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = "message"
    @State private var isPressed = false
    @EnvironmentObject var authManager: AuthManager
    @State private var isVerificationCodeSent: Bool = false
    @State private var navPath = NavigationPath()
    
    var body: some View {
       
        NavigationStack {
            ZStack {
                Color("white").ignoresSafeArea()
                VStack {
                    
                    Spacer().frame(height: 200)
                    
                    // Top Image
                    VStack {
                        Text("BOOKD")
                            .font(.custom("BarlowCondensed-ExtraBold", size: 56))
                            .foregroundStyle(Color("black"))
                        Text("Need More Gigs?\nGet BOOKD".uppercased())
                            .font(.custom("InterTight-Regular", size: 16))
                            .multilineTextAlignment(.center)
                            .padding(.top, 8)
                            .overlay(
                                ColorSaturationBG(blobs: [.red, .blue, .purple], speed: 0.2, overlay: false)
                                    .mask(
                                        Text("Need More Gigs?\nGet BOOKD".uppercased())
                                            .font(.custom("InterTight-Regular", size: 16))
                                            .multilineTextAlignment(.center)
                                            .padding(.top, 8)
                                    )
                            )
                    }
                    Spacer()
                    VStack(spacing: 10) {
                        if showAlert {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Error:".uppercased())
                                        .font(.custom("InterTight-Bold", size: 12))
                                    Text(alertMessage)
                                        .font(.custom("InterTight-Regular", size: 12))
                                }
                                Spacer()
                                Image(systemName: "xmark.circle.fill")
                                    .onTapGesture {
                                        showAlert.toggle()
                                    }
                            }
                            .foregroundColor(.accent)
                            .padding(.horizontal)
                            .padding(.vertical)
                            .background(Color.accent.opacity(0.2))
                            .padding(.bottom)
                        }
                        
                        
                        BookdTextField(
                            text: $phone,
                            prompt: "+1 555 555 5555",
                            type: .telephoneNumber
                        )
                        
                        
                        Spacer().frame(height: 60)
                        
                        // Email
                        Button {
                            authManager.sendVerificationCode(to: phone) { result in
                                switch result {
                                case .success:
                                    isVerificationCodeSent = true
                                case .failure(let error):
                                    print("Error sending verification code: \(error.localizedDescription)")
                                }
                            }
                            
                        }
                        label: {    Text("Sign In".uppercased())
                                .font(.custom("InterTight-Bold", size: 14))
                                .foregroundStyle(Color("black"))
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                                .background {
                                    ColorSaturationBG(
                                        blobs: [.red, .blue, .purple],
                                        speed: 0.4
                                    )
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
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
                                .padding(.horizontal)
                        }
                        Text("Need to sign up?")
                            .padding(.top)
                            .foregroundStyle(Color(.gray))
                            .font(.subheadline)
                    }
                }
            }
        }
        }
    
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen().environmentObject(AuthManager())
    }
}

struct BookdTextField: View {
    @Binding var text: String
    var prompt: String
    var type: UITextContentType
    var hPadding: CGFloat = 16
    var vPadding: CGFloat = 16
    var radius: CGFloat = 16
    var fontSize: CGFloat = 18
    var leadingText: String = ""

    var body: some View {
        HStack(spacing: 2) {
            if leadingText != "" {
                Text(leadingText)
                    .font(.custom("InterTight-Regular", size: fontSize))
            }
            TextField("", text: $text, prompt: Text(prompt.uppercased()).font(.custom("InterTight-Regular", size: fontSize)))
                .textContentType(type)
               
        }
        .padding(.horizontal, hPadding)
        .padding(.vertical, vPadding)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
        .padding(.horizontal)
            
    }
}
