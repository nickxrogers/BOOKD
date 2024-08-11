//
//  Discover.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/1/24.
//

import SwiftUI
import AVKit


struct Discover: View {
    

    var size: CGSize
    var safeArea: EdgeInsets
    // View Properties
    @State private var reels: [Reel] = reelsData
    @State private var likedCounter: [Like] = []
 
    
    
    var body: some View {
        
        
 
            
            ScrollView(.vertical) {
                
                          
                LazyVStack(spacing: 0) {

                    ForEach($reels) { $reel in
                        // Insert your view for each reel here
                        ReelView(reel: $reel,
                                 likeCounter: $likedCounter,
                                 size: size,
                                 safeArea: safeArea
                        )
                        .frame(maxWidth: .infinity)
                        .containerRelativeFrame(.vertical)
                    }
                }
                .scrollIndicators(.hidden)
                .scrollTargetLayout()
                
                .background(.black)
                .environment(\.colorScheme, .dark)
            }.scrollTargetBehavior(.paging)
                .edgesIgnoringSafeArea(.top)

    }
}



#Preview {
    ContentView()
}



