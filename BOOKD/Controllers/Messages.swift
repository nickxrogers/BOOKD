//
//  Messages.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/6/24.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

struct Messages: View {
    
    
    
    var body: some View {
        ChatChannelListView(viewFactory: CustomFactory.shared)
    }
}

#Preview {
    Messages()
}

public struct CustomChannelHeader: ToolbarContent {

    @Injected(\.fonts) var fonts
    @Injected(\.images) var images

    public var title: String
    public var onTapLeading: () -> ()

    public var body: some ToolbarContent {
       
        ToolbarItem(placement: .navigationBarTrailing) {
            NavigationLink {
                Text("This is injected view")
            } label: {
                Image(systemName: "plus.bubble")
                    .font(.title2)
                   
            }
        }
        ToolbarItem(placement: .navigationBarLeading) {
            Text("Messages".uppercased()).font(.custom("BarlowCondensed-ExtraBold", size: 32))
        }
    }
}

struct CustomChannelModifier: ChannelListHeaderViewModifier {

    var title: String

    @State var profileShown = false

    func body(content: Content) -> some View {
        content.toolbar {
            CustomChannelHeader(title: title) {
                profileShown = true
            }
        }
        .sheet(isPresented: $profileShown) {
            Text("Profile View")
        }
    }

}

class CustomFactory: ViewFactory {

    @Injected(\.chatClient) public var chatClient

    private init() {}

    public static let shared = CustomFactory()

    func makeChannelListHeaderViewModifier(title: String) -> some ChannelListHeaderViewModifier {
        CustomChannelModifier(title: title)
    }

}
