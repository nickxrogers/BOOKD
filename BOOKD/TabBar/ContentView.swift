//
//  ContentView.swift
//  BOOKD
//
//  Created by Nick Rogers on 7/31/24.
//

import SwiftUI
import BottomSheet

struct ContentView: View {
    
    @StateObject var settings = SheetSettings()
    @StateObject var authManager = AuthManager()
    @State var current = 0
    @State var expand = false
    @Namespace var animation
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "sheetbg") // This line changes the tab bar background color
        }
    

      
    var body: some View {
        NavigationView {
            if authManager.isAuthenticated {
        
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom),
                           content: {
                        TabView(selection: $current) {
                            
                            Home()
                                .tag(0)
                                .tabItem {
                                    Image(systemName: "rectangle.grid.2x2")
                                    Text("Home".uppercased()).font(.custom("InterTight-Regular", size: 8))
                                }
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
                            Messages()
                                .tag(4)
                                .tabItem {
                                    Image(systemName: "message")
                                    Text("Messages".uppercased()).font(.custom("InterTight-Regular", size: 8))
                                }
                        }.accentColor(Color("black"))
                        if current != 2 {
                            MiniPlayer(animation: animation, expand: $expand)
                        }
                        
                    })
                        
        
            } else {
                LoginScreen()
                    .environmentObject(authManager)
            }
        }
    }
}

#Preview {
    ContentView()
}
