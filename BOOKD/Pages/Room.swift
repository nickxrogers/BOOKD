//
//  Room.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/4/24.
//

import SwiftUI
import FluidGradient
import BottomSheet
import StreamVideo





class RoomSheetSettings: ObservableObject {
    @Published var isPresented = true
    @Published var activeSheetType: RoomSheetState = .controls
    @Published var selectedDetent: BottomSheet.PresentationDetent = .height(244)
    @Published var translation: CGFloat = BottomSheet.PresentationDetent.large.size
}

struct Room: View {
    
    @State var isPresented = true
    @StateObject var settings = RoomSheetSettings()



    
    @ViewBuilder
    var mainContent: some View {
        switch settings.activeSheetType {
        case .controls:
            RoomControlsView()
                .presentationDetentsPlus(
                    [.height(244), .medium, .large],
                    selection: $settings.selectedDetent
                )
        case .participants:
            Profile()
                .presentationDetentsPlus(
                    [.height(244), .height(380), .height(480), .large],
                    selection: $settings.selectedDetent
                )
                .presentationDragIndicatorPlus(.visible)
                .presentationBackgroundInteractionPlus(.enabled(upThrough: .height(380)))
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    var headerContent: some View {
        switch settings.activeSheetType {
        case .controls:
            RoomControlsHeader()
        case .participants:
            StaticScrollViewHeader()
        default:
            EmptyView()
        }
    }
    
 
    
    var body: some View {
        ZStack {
            FluidGradient(blobs: [.red, .pink, .blue], highlights: [.white, .pink, .purple], speed: 0.2)
                .ignoresSafeArea()
                .overlay(.regularMaterial)
            VStack(alignment: .leading) {
                HStack {
                    Text("Room")
                        .font(.largeTitle).bold()
                        .padding()
                    Spacer()
                }.padding(.horizontal)
                Spacer()
            }.sheetPlus(
                isPresented: $isPresented,
                background: (
                    Color(UIColor.secondarySystemBackground)
                        .cornerRadius(12)
                ),
                onDrag: { translation in
                    settings.translation = translation
                    print(translation)
                },
                header: { headerContent },
                main: {
                    mainContent
                        
                }
            )
        }
    }
}

#Preview {
    Room()
}
