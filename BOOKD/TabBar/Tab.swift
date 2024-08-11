//
//  Tab.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/9/24.
//

import SwiftUI

struct Tab: View {
    
    @StateObject var settings = SheetSettings()
    @StateObject var authManager = AuthManager()
    @State var current = 0
    @State var expand = false
    @Namespace var animation
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "sheetbg") // This line changes the tab bar background color
        }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom),
               content: {
            TabView(selection: $current) {
                Profile()
                    .tag(1)
                    .tabItem {
                        Image(systemName: "safari")
                        Text("Discover".uppercased()).font(.custom("InterTight-Regular", size: 8))
                    }
                MapView()
                    .tag(2)
                    .tabItem {
                        Image(systemName: "map")
                        Text("Map".uppercased()).font(.custom("InterTight-Regular", size: 8))
                    }
                
                Social()
                    .tag(3)
                    .tabItem {
                        Image(systemName: "person.2")
                        Text("Social".uppercased()).font(.custom("InterTight-Regular", size: 8))
                    }
           
            }.accentColor(Color("black"))
            if current != 2 {
                MiniPlayer(animation: animation, expand: $expand)
            }
            
        })    }
}

#Preview {
    Tab()
}
