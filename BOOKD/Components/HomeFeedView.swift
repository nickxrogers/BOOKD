//
//  HomeFeedView.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/3/24.
//

import SwiftUI
import FluidGradient
import ColorKit

let SampleSongList: [SongDiscoverExamples] = [
    SongDiscoverExamples(id: "1", name: "Sunset Dreams", image: "hellokitty", artist: "Echoes of Eternity"),
    SongDiscoverExamples(id: "2", name: "Mystic Waves", image: "books", artist: "Oceanic Symphony"),
    SongDiscoverExamples(id: "3", name: "Golden Horizon", image: "cool", artist: "Sunrise Serenade"),
    SongDiscoverExamples(id: "4", name: "Starlit Night", image: "pop", artist: "Galactic Groove"),
    SongDiscoverExamples(id: "5", name: "Whispering Pines", image: "cupid", artist: "Forest Echoes"),
    SongDiscoverExamples(id: "6", name: "Radiant Dawn", image: "album", artist: "Morning Light")
]

struct HomeFeedView: View {
    
    @State var bgBlobs: [Color] = [.clear]
    @State var artistName: String = "none"
    @State var bg: Color = .clear
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            GeometryReader { geo in
                VStack(alignment: .leading, spacing: 0.0) {
                    Text("Rooms".uppercased())
                        .font(.custom("InterTight-Bold", size: 14))
                        .foregroundStyle(.red)
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.top)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(1...5, id: \.self) { rooms in
                                NavigationLink(destination: Room()) {
                                    SmallRoomCardView()
                                        .containerRelativeFrame([.horizontal], count: 2, spacing: 10.0)
                                        .contextMenu {
                                            Button {
                                                print("Change country setting")
                                            } label: {
                                                Label("Choose Country", systemImage: "globe")
                                            }
                                            Button {
                                                print("Enable geolocation")
                                            } label: {
                                                Label("Detect Location", systemImage: "location.circle")
                                            }
                                        }
                                }
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .safeAreaPadding(.all)
                    HStack(alignment: .center) {
                            Spacer()
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(SampleSongList) { song in
                                        if let uiImage = UIImage(named: song.image) {
                                            VerticalSongCard(dominantColors: SongItem(image: uiImage).dominantColors, generatedPalette: SongItem(image: uiImage).generatedPalette, averageColor: SongItem(image: uiImage).averageColor, textColor: .white, image: UIImage(named: song.image)!)
                                            // .onAppear {
                                            //     bg = SongItem(image: UIImage(named: song.image)!).averageColor
                                            //     bgBlobs.append(SongItem(image: UIImage(named: song.image)!).averageColor)
                                            // }
                                                .scrollTransition(axis: .horizontal) { content, phase in
                                                    content
                                                        .opacity(phase.isIdentity ? 1 : 0)
                                                        .blur(radius: phase.isIdentity ? 0 : 10)
                                                }
                                        } else {
                                            // Handle the case where the image is nil
                                            Text("Image not found")
                                        }
                                    }
                                    
                                }
                                .frame(height: 300)
                                .edgesIgnoringSafeArea(.all)
                                .scrollTargetLayout()
                            }
                            .ignoresSafeArea()
                            
                            .scrollTargetBehavior(.viewAligned)
                        }
                        .padding(.vertical)
                        .padding(.bottom)
                     
                   
                    
                    Divider()
                    
                    PostCardView()
                    PostCardView()
                    PostCardView()
                    
                    Spacer()
                }
            }
           
        }
    }
}


#Preview {
    HomeFeedView()
}


struct SmallRoomCardView: View {

    
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Chlochella").font(.custom("InterTight-Regular", size: 24))
                        .padding(.top).padding(.horizontal, 8)
                    Spacer()
                    Image(systemName: "dot.radiowaves.right")
                        .font(.headline)
                        .symbolEffect(.bounce.up.byLayer, options: .speed(0.3))
                        
                        .padding(.top)
                        .padding(.horizontal)
                }
                Spacer().frame(height: 30)
                Text("12 People Listening".uppercased()).font(.custom("InterTight-ExtraBold", size: 14)).bold()
                    .padding(.bottom).padding(.horizontal, 8)
            }
        }
        .frame(height: 90)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        
        
    }
}

struct VerticalSongCard: View {
    
    @State private var isPlaying = false
    @State  var dominantColors: [Color]
    @State  var generatedPalette: [Color]
    @State  var averageColor: Color
    @State  var textColor: Color
    @State  var image: UIImage

    
    var body: some View {
        ZStack {
            FluidGradient(blobs: generatedPalette,
                          highlights: dominantColors,
                          speed: 0.1,
                          blur: 0.1)
            
            Rectangle().fill(.thickMaterial)
            
            VStack {
                Image("hellokitty")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150,height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .padding(.all)
                    
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text("Broken").font(.custom("InterTight-Regular", size: 28))
                            
                        Text("XN, ATAY".uppercased()).font(.custom("InterTight-ExtraBold", size: 14)).bold()
                            
                            .padding(.bottom)
                    }
                    Spacer()
                    Button {
                        withAnimation {
                            isPlaying.toggle()
                        }
                    } label: {
                        Image(systemName:isPlaying ? "pause.circle.fill": "play.circle.fill")
                    }
                    .foregroundStyle(Color.accent)
                    .contentTransition(.symbolEffect(.replace))
                    .font(.system(size: 36))
                    .padding(.bottom)
                    
                    
                }.padding(.horizontal)
            }
        }.onAppear {
            SongItem(image: image).extractColors(from: image)
   
        }
        .frame(height: 250)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(radius: 10)
        
        
    }
}

struct PostCardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("nick")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text("Nick Rogers").font(.custom("InterTight-SemiBold", size: 12))
                    Text("@nickswoke").font(.custom("InterTight-Regular", size: 10))
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("Follow".uppercased())
                        .font(.system(size: 12))
                        .foregroundStyle(Color.black)
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }.padding(.top)
            .padding(.horizontal)
            
            Text("Had a great time at the show last night. Met a lot of interesting people and saw some really talented performers. It was a cool experience overall. Looking forward to the next one.")
                .font(.system(size: 14))
                .padding()
            HStack(spacing: 16) {
                Button {
                    
                } label: {
                    Image(systemName: "heart")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "repeat")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                }
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis.bubble")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                }
                
            }.padding(.horizontal)
                .padding(.bottom)
            
        }
        .background(Color("white"))
    }
}
