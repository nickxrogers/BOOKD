//
//  Auth.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/7/24.
//



import Foundation
import FirebaseAuth
import FirebaseFunctions
import Combine
import StreamChatSwiftUI
import StreamChat
import StreamVideo

class AuthManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    private lazy var functions = Functions.functions()
    private var streamUserToken: String?
    private var errorMessage: String?
    var streamChat: StreamChat?
    private var verificationID: String?

    init() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.isAuthenticated = user != nil
        }
    }

    deinit {
        if let handle = authStateDidChangeListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }

    // Phone Authentication Methods
    func sendVerificationCode(to phoneNumber: String, completion: @escaping (Result<Void, Error>) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.verificationID = verificationID
                completion(.success(()))
            }
        }
    }

    func signIn(with verificationCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let verificationID = verificationID else {
            completion(.failure(NSError(domain: "AuthManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Verification ID not found"])))
            return
        }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
