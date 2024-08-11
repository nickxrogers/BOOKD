//
//  ReelView.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/4/24.
//

import SwiftUI
import AVKit

struct ReelView: View {
    @Binding var reel: Reel
    @Binding var likeCounter: [Like]
    var size: CGSize
    var safeArea: EdgeInsets
    @State private var player: AVPlayer?
    var body: some View {
        GeometryReader { geo in
                CustomVideoPlayer(player: $player)
                    .onAppear {
                        guard player == nil else { return }
                        guard let bundleID = Bundle.main.path(forResource: reel.videoID, ofType: "mp4") else {return }
                        let videoURL = URL(filePath: bundleID)
                        player = AVPlayer(url: videoURL)
                    }
                    .onDisappear {
                        player = nil
                    }
                  
           
        }
    }
    
    func ReelDetailsView() -> some View {
        HStack(alignment: .bottom, spacing: 10) {
            VStack(alignment: .leading , content: {
                HStack(spacing: 10) {
                    Image(systemName: "person.circle.fill")
                        .font(.largeTitle)
                    Text(reel.authorName)
                        .font(.callout)
                        .lineLimit(1)
                }
                .foregroundStyle(.white)
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting Industry")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .clipped()
            })
            Spacer(minLength: 0)
            
            VStack(spacing: 35) {
                Button("", systemImage: reel.isLiked ? "suit.heart.fill" : "suit.heart") {
                    reel.isLiked.toggle()
                }
                
                Button("", systemImage: "message") { }
                
                Button("", systemImage: "paperplane") { }
                
                Button("", systemImage: "ellipsis") { }
                
            }
            .font(.title2)
            .foregroundStyle(.white)
        }
        .padding(.leading, 15)
        .padding(.trailing, 10)
       
        
    }

    
}

#Preview {
    ContentView()
}
