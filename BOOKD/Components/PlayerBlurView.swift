//
//  PlayerBlurView.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/8/24.
//

import SwiftUI

struct PlayerBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
    
}

#Preview {
    PlayerBlurView()
}
