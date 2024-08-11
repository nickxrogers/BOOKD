//
//  BOOKDTests.swift
//  BOOKDTests
//
//  Created by Nick Rogers on 8/2/24.
//

import Testing
import SwiftUI
import Foundation
import Combine

struct BOOKDTests {

    
    
    @Test(arguments: ["https://firebasestorage.googleapis.com/v0/b/bookd-98e12.appspot.com/o/users%2Fadmin%2F444800195_1856386504825979_4178007271598796388_n.jpg?alt=media&token=63b53992-054c-45db-b244-4f458bfff0b1"])  func loadImage(from firebaseURL: String) {
        // Base URL for TwicPics
        let twicPicsBaseURL = "https://bookd.twic.pics/"
        let firebaseBaseURL = "https://firebasestorage.googleapis.com/v0/b/bookd-98e12.appspot.com/o/"
        let suffix = "&twic=v1/resize=-x200/quality=100"
        
        // Replace Firebase base URL with TwicPics base URL
        
        guard let twicPicsURL = firebaseURL.replacingOccurrences(of: firebaseBaseURL, with: twicPicsBaseURL).appending(suffix).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: twicPicsURL) else {
            print("Invalid URL")
            return
        }
        let expectedURL = URL(string: "https://bookd.twic.pics/users%2Fadmin%2F444800195_1856386504825979_4178007271598796388_n.jpg?alt=media&token=63b53992-054c-45db-b244-4f458bfff0b1&twic=v1/resize=-x200/quality=100")
        print(twicPicsURL)
        
        // Set the transformed URL
        DispatchQueue.main.async {
            print(url)
        }
        #expect(url == expectedURL)
    }

}
