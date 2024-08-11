//
//  BOOKDApp.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/2/24.
//

import SwiftUI
import StreamVideo
import UIKit
import StreamChat
import StreamChatSwiftUI
import Firebase
import FirebaseFunctions
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct BOOKDApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var viewModel = StreamChatViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

class StreamChatViewModel: ObservableObject {
    @Published var streamUserToken: String?
    @Published var errorMessage: String?
    
    private lazy var functions = Functions.functions()
    private let apiKey: String = "vynqjdbnt8uk"

    var chatClient: ChatClient
    var streamChat: StreamChat?

    init() {
        // Initialize ChatClient with the custom color palette
        self.chatClient = StreamChatViewModel.initializeChatClient(key: apiKey)
        self.streamChat = StreamChat(chatClient: chatClient, appearance: StreamChatViewModel.customAppearance())
        
        fetchStreamUserToken()
    }

    // Function to initialize ChatClient with the custom color palette
    static func initializeChatClient(key: String) -> ChatClient {
        var config = ChatClientConfig(apiKey: .init(key))
        config.isLocalStorageEnabled = true
        config.applicationGroupIdentifier = "bookd.app"
        return ChatClient(config: config)
    }

    // Function to create a custom Appearance with custom ColorPalette
    static func customAppearance() -> Appearance {
        // Define your custom colors
        let streamBlue = UIColor(.white)
        
        // Create a custom ColorPalette and set the desired color properties
        var colors = ColorPalette()
        colors.tintColor = Color(streamBlue)
        
        // Create and return an Appearance object with your custom ColorPalette
        return Appearance(colors: colors)
    }

    func fetchStreamUserToken() {
        functions.httpsCallable("ext-auth-chat-getStreamUserToken").call { [weak self] result, error in
            if let error = error as NSError? {
                self?.errorMessage = "Error: \(error.localizedDescription)"
                return
            }

            if let token = result?.data as? String {
                self?.streamUserToken = token
                self?.connectUser()
            } else {
                self?.errorMessage = "Invalid response from server."
            }
        }
    }

    func connectUser() {
        guard let tokenString = streamUserToken else {
            errorMessage = "Stream user token is unavailable."
            return
        }

        let token: Token
        do {
            token = try Token(rawValue: tokenString)
        } catch {
            errorMessage = "Invalid token string: \(error.localizedDescription)"
            return
        }
        
        guard let currentUser = Auth.auth().currentUser else {
            errorMessage = "No authenticated user found."
            return
        }

        chatClient.connectUser(
            userInfo: .init(
                id: currentUser.uid,
                name: currentUser.displayName,
                imageURL: currentUser.photoURL
            ),
            token: token
        ) { error in
            if let error = error {
                self.errorMessage = "Connecting the user failed: \(error)"
                return
            }
        }
    }
}
