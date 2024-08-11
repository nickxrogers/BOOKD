//
//  RoomControlsView.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/4/24.
//

import SwiftUI

struct RoomControlsView: View {
    
    @State var muted = false
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Button {
                    
                } label: {
                    Text("Raise Hand".uppercased())
                        .font(.custom("InterTight-Bold", size: 12))
                        .foregroundStyle(Color("black"))
                        .padding(.horizontal)
                        .padding(.vertical)
                        .background(.thickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
                Button {
                    muted.toggle()
                } label: {
                    Image(systemName: "microphone.fill")
                        .foregroundColor(muted ? .red : .blue)
                        .font(.system(size: 16))
                        .padding()
                        .background(.thickMaterial)
                        .clipShape(Circle())
                }
            }
        }
    }
}

#Preview {
    RoomControlsView()
}
