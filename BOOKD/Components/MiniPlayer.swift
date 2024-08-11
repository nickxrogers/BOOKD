//
//  MiniPlayer.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/8/24.
//

import SwiftUI

struct MiniPlayer: View {
    
    var animation: Namespace.ID
    @Binding var expand: Bool
    
    var height = UIScreen.main.bounds.height / 3
    var safeArea = UIApplication.shared.windows.first?.safeAreaInsets
    @State var volume: CGFloat = 0
    @State var offset: CGFloat = 0
    
    var body: some View {
        VStack {
            Capsule()
                .fill(.gray)
                .frame(width: expand ? 60 : 0, height: expand ? 4 : 0)
                .opacity(expand ? 1 : 0)
                .padding(.top, expand ? safeArea?.top : 0)
                .padding(.vertical, expand ? 30 : 0)
            HStack(spacing: 15) {
                
                if expand {
                    Spacer(minLength: 0)
                }
                
                Image("hellokitty")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: expand ? height : 45, height: expand ? height : 45)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                
                if !expand {
                    Text("BROKEN")
                        .font(.custom("InterTight-Bold", size: 14))
                        .matchedGeometryEffect(id: "Label", in: animation)
                }
                Spacer(minLength: 0)
                if !expand {
                    Button {
                        
                    } label: {
                        Image(systemName: "play.fill")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }

                }
                
            }
            .padding(.horizontal)
            VStack(spacing: 15) {
                Spacer(minLength: 0)
                HStack {
                    if expand {
                        Text("BROKEN")
                            .font(.custom("InterTight-Bold", size: 20))
                            .foregroundStyle(.primary)
                            .matchedGeometryEffect(id: "Label", in: animation)
                    }
                    Spacer(minLength: 0)
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        
                    }
                }
                .padding()
                .padding(.top, 20)
                HStack {
                    Capsule()
                        .fill(
                            LinearGradient(gradient: .init(colors: [Color.primary.opacity(0.7), Color.primary.opacity(0.1)]), startPoint: .leading, endPoint: .trailing)
                        )
                        .frame(height: 4)
                    Text("LIVE")
                        .font(.custom("Intertight-Bold", size: 14))
                        .foregroundStyle(.primary)
                    Capsule()
                        .fill(
                            LinearGradient(gradient: .init(colors: [Color.primary.opacity(0.1), Color.primary.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
                        )
                        .frame(height: 4)
                }
                .padding()
                Button {
                    
                } label: {
                    Image(systemName: "play.fill")
                        .font(.largeTitle)
                        .foregroundStyle(Color.primary)
                }
                Spacer(minLength: 0)
                HStack(spacing: 15) {
                    Image(systemName: "speaker.fill")
                    Slider(value: $volume)
                    Image(systemName: "speaker.wave.2.fill")
                }
                .padding()
                
                HStack(spacing: 22) {
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.up.message")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    Button {
                        
                    } label: {
                        Image(systemName: "airplayaudio")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    Button {
                        
                    } label: {
                        Image(systemName: "list.bullet")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.bottom, safeArea?.bottom == 0 ? 15 : safeArea?.bottom)
            }
            .frame(height: expand ? nil : 0)
            .opacity(expand ? 1 : 0)
        }
        .frame(maxHeight: expand ? .infinity : 60)
        .background {
            VStack(spacing: 0) {
                PlayerBlurView()
                Divider()
            }
            .onTapGesture {
                withAnimation(.spring()) {
                    expand = true
                }
            }
           
        }
        .offset(y: expand ? 0 : -48)
        .offset(y: offset)
        .gesture(DragGesture().onEnded(onEnded(value:)).onChanged(onChanged(value:)))
        .ignoresSafeArea()
    }
    func onChanged(value: DragGesture.Value) {
        if value.translation.height > 0 && expand {
            offset = value.translation.height
        }
    }
    func onEnded(value: DragGesture.Value) {
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.95)) {
            if value.translation.height > height {
                expand = false
            }
            offset = 0
        }
    }
}

