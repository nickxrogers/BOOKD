//
//  SignUp.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/9/24.
//

import SwiftUI

struct SignUp: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = "message"
    @State private var isPressed = false
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
       
        VStack(alignment: .leading) {
                
                        Text("Sign Up")
                    .font(.custom("InterTight-ExtraBold", size: 32))
                    .padding(.horizontal)
                            Spacer()
                        TextField("", text: $email, prompt: Text("Email".uppercased()).font(.custom("InterTight-Bold", size: 18)))
                            .tint(Color.accentColor)
                            .padding(.horizontal)
                            .padding(.vertical)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .padding(.horizontal)
                            
                        
                        TextField("".uppercased(), text: $password, prompt: Text("Password".uppercased()).font(.custom("InterTight-Bold", size: 18)))
                            .tint(Color.accentColor)
                            .padding(.horizontal)
                            .padding(.vertical)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .padding(.horizontal)
                        
                        Spacer().frame(height: 30)
                           
                        // Email
                        GradientButton(
                            action: {print("pressed")},
                            label: "Continue"
                        )
            VStack(alignment: .center) {
                Text("Need to sign up?")
                    .padding(.top)
                    .foregroundStyle(Color(.gray))
                    .font(.subheadline)
            }
            .frame(width: UIScreen.main.bounds.width)
                            
                    }
                }
            }
        

#Preview {
    SignUp().environmentObject(AuthManager())
}
