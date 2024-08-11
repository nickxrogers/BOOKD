//
//  CityView.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/8/24.
//

import SwiftUI
import Foundation
import Firebase
import Alamofire
import SDWebImageSwiftUI

struct CityView: View {
    @State var imageURL: URL?
    @EnvironmentObject var settings: SheetSettings  // Use @EnvironmentObject to get settings
    
    private let city = "San Antonio" // Change this to any city you like
    private let apiKey = "AIzaSyBd1Bt3XMEnFSKXvB0rpdxXCfF0bYtXtks" // Replace with your actual API key

    private func fetchPlaceDetails(for city: String) {
        let searchURL = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json"
        let parameters: [String: Any] = [
            "input": city,
            "inputtype": "textquery",
            "fields": "photos,place_id",
            "key": apiKey
        ]
        
        AF.request(searchURL, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any],
                   let candidates = json["candidates"] as? [[String: Any]],
                   let firstCandidate = candidates.first,
                   let photos = firstCandidate["photos"] as? [[String: Any]],
                   let photoReference = photos.first?["photo_reference"] as? String {
                    fetchPhoto(from: photoReference)
                }
            case .failure(let error):
                print("Error fetching place details: \(error)")
            }
        }
    }

    private func fetchPhoto(from reference: String) {
        let photoURL = "https://maps.googleapis.com/maps/api/place/photo"
        let parameters: [String: Any] = [
            "maxwidth": 400,
            "photoreference": reference,
            "key": apiKey
        ]
        
        let urlString = "\(photoURL)?maxwidth=400&photoreference=\(reference)&key=\(apiKey)"
        if let url = URL(string: urlString) {
            self.imageURL = url
        }
    }
    
    private func blurRadius(for translation: CGFloat) -> CGFloat {
        let minTranslation: CGFloat = 500
        let maxTranslation: CGFloat = 766.8
        let maxBlurRadius: CGFloat = 20.0
        
        if translation >= maxTranslation {
            return maxBlurRadius
        } else if translation <= minTranslation {
            return 0
        } else {
            let normalizedTranslation = (translation - minTranslation) / (maxTranslation - minTranslation)
            return normalizedTranslation * maxBlurRadius
        }
    }

    var body: some View {
        VStack {
            if let imageURL = imageURL {
                WebImage(url: imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .mask(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .blur(radius: blurRadius(for: settings.translation))  // Apply blur radius based on settings.translation
            } else {
                ProgressView()
            }
        }
        .frame(height: 300)
        .ignoresSafeArea()
        .onAppear {
            fetchPlaceDetails(for: city)
        }
    }
}
