//
//  DataTypes.swift
//  BOOKD
//
//  Created by Nick Rogers on 7/31/24.
//

import Foundation
import SwiftUI
import Combine


struct Gig: Identifiable {
    var id: String
    var title: String
    var description: String
    var owner: String
    var validatedParking: Bool
    var instantPay: Bool
    var attachedVenue: VenueInfo?
}

struct ProfileData: Identifiable {
    var id: String
    var userName: String?
    var name: String?
    var profilePhotoURL: String?
    var coverPhotoURL: String?
    var bio: String?
    var onboarded: Bool?
}

struct Post: Identifiable, Codable {
    var id: String?
    var username: String
    var content: String
    var timestamp: Date
    var likes: Int
    var comments: [Comment]
}

struct Comment: Identifiable, Codable {
    var id: String?
    var username: String
    var content: String
    var timestamp: Date
}

struct CustomImage: Codable {
    var id: String
    var url: String
    var title: String
    var description: String?
}

class OnboardingData: ObservableObject {
    @Published var name: String = ""
    @Published var userName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var phoneNumber: String = ""
    @Published var profilePic: UIImage? = nil
    @Published var completed: Bool = false
    // Add other fields as needed
}

struct roomItem: Identifiable {
    var id: String
    var name: String
    var description: String
    var invited: [String]
    var isPrivate: Bool
    var owner: String
    var created: Date
}

struct userData: Identifiable {
    var id: String
    var userName: String?
    var name: String?
    var profilePhotoURL: String?
    var coverPhotoURL: String?
    var ref: String
}

struct DiscoverMedia: Identifiable {
    var id: String
    var name: String
    var image: Image
    var videoUrl: String
    var comment: String
    var likes: Int
}

struct SongDiscoverExamples: Identifiable {
    var id: String
    var name: String
    var image: String
    var artist: String
}

enum RoomSheetState {
    case controls
    case participants
    
}

import SwiftUI

/// Reel Model & Sample Video Files
struct Reel: Identifiable {
    var id: UUID = .init()
    var videoID: String
    var authorName: String
    var isLiked: Bool = false
}

var reelsData: [Reel] = [
    .init(videoID: "https://www.pexels.com/video/sea-waves-crashing-the-cliff-coast-6010489/", authorName: "Tima Miroshnichenko"),
    .init(videoID: "https://www.pexels.com/video/panning-shot-of-the-sea-at-sunset-6202759/", authorName: "Reel 1"),
    .init(videoID: "https://www.pexels.com/video/sea-waves-causing-erosion-on-the-shore-rocks-formation-6010502/", authorName: "Reel 2"),
    .init(videoID: "https://www.pexels.com/video/close-up-shot-of-a-water-falls-8242987/", authorName: "Reel 3"),
    .init(videoID: "https://www.pexels.com/video/calm-river-under-blue-sky-and-white-clouds-5145199/", authorName: "Reel 4"),
    .init(videoID: "Reel 5", authorName: "Anna Medvedeva")
]


struct Like: Identifiable {
    let id = UUID()
    var tappedRect: CGPoint = .zero
    var isAnimated: Bool = false
}

struct Colab: Identifiable {
    var id: String
    var title: String
    var artistOne: String
    var artistTwo: String
    var imageOne: Image
    var imageTwo: Image
    var duration: String
}


class SocialMediaData: ObservableObject {
    @Published var posts: [Post] = [
        Post(id: "1", username: "cassi b", content: "Just finished an amazing jam session with the band! 🎸 We played some of our favorite tracks and even experimented with a few new ones. The energy was incredible, and I can't wait to do it again. It's moments like these that remind me why I love making music. 🎶", timestamp: Date(), likes: 120, comments: [
            Comment(id: "1", username: "atay", content: "Wish I could've been there!", timestamp: Date()),
            Comment(id: "2", username: "ebo", content: "Sounds awesome! When's the next one?", timestamp: Date())
        ]),
        Post(id: "2", username: "cassi b", content: "Excited to announce my next gig at The Blue Note! 🎤 It's going to be a special night with some surprise guests and new songs that I've been working on. Make sure to mark your calendars and come out to support. I promise it will be a night to remember!", timestamp: Date(), likes: 95, comments: [
            Comment(id: "3", username: "cupid", content: "Can't wait to see you perform!", timestamp: Date())
        ]),
        Post(id: "3", username: "cassi b", content: "Working on some new tracks in the studio today. 🎧 Spent hours perfecting the sound and experimenting with different instruments. It's a lot of hard work, but the end result is always worth it. Can't wait to share these new songs with everyone. Stay tuned!", timestamp: Date(), likes: 80, comments: [
            Comment(id: "4", username: "ebo", content: "Looking forward to hearing them!", timestamp: Date()),
            Comment(id: "5", username: "atay", content: "Studio days are the best days.", timestamp: Date())
        ]),
        Post(id: "4", username: "cassi b", content: "Just booked an amazing venue for our next event! 🏟️ It's a beautiful space with great acoustics and plenty of room for everyone to dance and enjoy the music. We're planning some exciting performances and collaborations, so make sure to get your tickets early. This is going to be one for the books!", timestamp: Date(), likes: 110, comments: [
            Comment(id: "6", username: "cupid", content: "That's fantastic! Which venue?", timestamp: Date()),
            Comment(id: "7", username: "ebo", content: "Can't wait to check it out.", timestamp: Date())
        ]),
        Post(id: "5", username: "cassi b", content: "Had a blast hosting last night's open mic! 🎙️ The talent was incredible, and it was amazing to see so many people come out to support local artists. We had singers, musicians, poets, and even a few comedians. Nights like these remind me of the power of community and the importance of supporting each other. Can't wait for the next one!", timestamp: Date(), likes: 150, comments: [
            Comment(id: "8", username: "atay", content: "You did an amazing job!", timestamp: Date()),
            Comment(id: "9", username: "cupid", content: "It was such a fun night.", timestamp: Date())
        ]),
        Post(id: "6", username: "cassi b", content: "Trying out some new gear for my next performance. 🎹", timestamp: Date(), likes: 70, comments: [
            Comment(id: "10", username: "ebo", content: "Let us know how it sounds!", timestamp: Date())
        ]),
        Post(id: "7", username: "cassi b", content: "Just watched an incredible live performance. 🎶 The artist was so talented and the energy in the room was electric. It's always inspiring to see other musicians doing what they love and connecting with the audience. It makes me even more excited for my own upcoming shows.", timestamp: Date(), likes: 130, comments: [
            Comment(id: "11", username: "atay", content: "Which artist?", timestamp: Date()),
            Comment(id: "12", username: "cupid", content: "I love live music!", timestamp: Date())
        ]),
        Post(id: "8", username: "cassi b", content: "Feeling inspired after today's songwriting session. ✍️ Spent the afternoon with my guitar and a notebook, just letting the ideas flow. Sometimes the best songs come from these spontaneous moments of creativity. Can't wait to share these new lyrics with you all.", timestamp: Date(), likes: 90, comments: [
            Comment(id: "13", username: "ebo", content: "Can't wait to hear your new songs!", timestamp: Date())
        ]),
        Post(id: "9", username: "cassi b", content: "Just got some new merch for the band! 👕 We've got t-shirts, hoodies, and even some cool accessories. The designs are awesome, and I think you all are going to love them. Make sure to grab yours at our next show or order online. Thanks for supporting us!", timestamp: Date(), likes: 85, comments: [
            Comment(id: "14", username: "atay", content: "Looks great! Where can I get one?", timestamp: Date()),
            Comment(id: "15", username: "cupid", content: "I need to grab some merch too!", timestamp: Date())
        ]),
        Post(id: "10", username: "cassi b", content: "Enjoying a quiet evening practicing my setlist. 🎵 It's important to take the time to perfect each song and make sure everything flows smoothly. I'm really excited about this set and can't wait to perform it live. Practice makes perfect!", timestamp: Date(), likes: 100, comments: [
            Comment(id: "16", username: "ebo", content: "Sounds like a perfect evening.", timestamp: Date()),
            Comment(id: "17", username: "atay", content: "Practice makes perfect!", timestamp: Date())
        ])
    ]
}

struct VenueInfo: Identifiable {
    var id = UUID()
    var name: String
    var address: String
    var city: String
    var state: String
    var zipCode: String
    var country: String
    var phoneNumber: String
    var email: String
    var website: String
    var description: String
    var capacity: Int
    var amenities: [String]
    var imageUrl: String
    var bannerUrl: String
    var latitude: Double
    var longitude: Double
    var rating: Double
    var reviews: [String]
    var openingHours: [String: String]
    var events: [String]
}

class SampleVenuesList: ObservableObject {
    @Published var venues: [VenueInfo] = [
    
        VenueInfo(
            id: UUID(),
            name: "Tryst. Kitchen + Cocktails",
            address: "1915 Broadway St, Ste 111",
            city: "San Antonio",
            state: "TX",
            zipCode: "78215",
            country: "USA",
            phoneNumber: "N/A",
            email: "N/A",
            website: "https://www.mysanantonio.com/food/article/tryst-kitchen-cocktails-19541443.php",
            description: "Elevates Southern cuisine with Wagyu beef, fresh seafood, and innovative takes on soul food classics.",
            capacity: 100,
            amenities: ["Full Bar", "Live Music", "Outdoor Seating"],
            imageUrl: "https://firebasestorage.googleapis.com/v0/b/bookd-98e12.appspot.com/o/users%2Fsamplevenues%2F447302503_122104068758338096_9179651594626244116_n.jpg?alt=media&token=8cf3fa40-3f05-4fe8-8c13-5b4ce44a63ab", bannerUrl: "https://firebasestorage.googleapis.com/v0/b/bookd-98e12.appspot.com/o/users%2Fsamplevenues%2F453501075_122122193000338096_5422088276652586206_n.jpg?alt=media&token=2f23462e-bc2e-4658-a424-16d8984a3a2f",
            latitude: 29.4386,
            longitude: -98.4816,
            rating: 4.5,
            reviews: ["placeholder_review"],
            openingHours: ["Monday": "Closed", "Tuesday": "Closed", "Wednesday": "11:00 AM - 2:00 PM", "Thursday": "11:00 AM - 2:00 PM", "Friday": "11:00 AM - 2:00 PM", "Saturday": "11:00 AM - 2:00 PM", "Sunday": "11:00 AM - 2:00 PM"],
            events: ["placeholder_event"]
        ),
           VenueInfo(
            id: UUID(),
               name: "Scott Gertner’s Rhythm Room",
               address: "5535 Memorial Dr Ste G",
               city: "Houston",
               state: "TX",
               zipCode: "77007",
               country: "USA",
               phoneNumber: "(832) 804-9046",
               email: "N/A",
               website: "https://scottgertnermusic.com/",
               description: "Houston’s top destination for live R&B and Jazz entertainment, delicious American and Southern hip cuisine.",
               capacity: 150,
               amenities: ["Full Bar", "Live Music", "VIP Sections"],
            imageUrl: "https://firebasestorage.googleapis.com/v0/b/bookd-98e12.appspot.com/o/users%2Fsamplevenues%2FScreenshot%202024-08-08%20at%209.36.22%E2%80%AFPM.png?alt=media&token=b43cf7bd-749f-447e-9ca4-d48596b10e02", bannerUrl: "https://firebasestorage.googleapis.com/v0/b/bookd-98e12.appspot.com/o/users%2Fsamplevenues%2Flarge.jpg?alt=media&token=664f117d-f1f1-4edd-80c0-42f466d875ca",
               latitude: 29.7643,
               longitude: -95.4094,
               rating: 4.5,
               reviews: ["placeholder_review"],
               openingHours: ["Wednesday": "5:30 PM - 12:00 AM", "Thursday": "5:30 PM - 12:00 AM", "Friday": "7:00 PM - 2:00 AM", "Saturday": "7:00 PM - 2:00 AM", "Sunday": "3:30 PM - 12:00 AM"],
               events: ["placeholder_event"]
           ),
           VenueInfo(
            id: UUID(),
               name: "The Livin Room",
               address: "3520 Old Spanish Trail",
               city: "Houston",
               state: "TX",
               zipCode: "77021",
               country: "USA",
               phoneNumber: "346.677.2354",
               email: "leday58@gmail.com",
               website: "https://www.blackbookhouston.com/post/the-liv-n-room",
               description: "A bar & lounge where you'll enjoy evenings with smooth libations and high frequency music.",
               capacity: 120,
               amenities: ["Full Bar", "Live Music", "Hookah"],
            imageUrl: "https://firebasestorage.googleapis.com/v0/b/bookd-98e12.appspot.com/o/users%2Fsamplevenues%2Fimages.jpeg?alt=media&token=6c5e488b-856d-47fd-b48a-5e8d8f9885fd", bannerUrl: "https://firebasestorage.googleapis.com/v0/b/bookd-98e12.appspot.com/o/users%2Fsamplevenues%2F442270905_1181948416132586_5219273965188028559_n.jpg?alt=media&token=0d6739e3-2d4a-4748-8be8-b83b968051a0",
               latitude: 29.7030,
               longitude: -95.3625,
               rating: 4.4,
               reviews: ["placeholder_review"],
               openingHours: ["Monday": "Closed", "Tuesday": "Closed", "Wednesday": "4:00 PM - 12:00 AM", "Thursday": "4:00 PM - 12:00 AM", "Friday": "4:00 PM - 12:00 AM", "Saturday": "4:00 PM - 12:00 AM", "Sunday": "4:00 PM - 12:00 AM"],
               events: ["placeholder_event"]
           ),
           VenueInfo(
            id: UUID(),
               name: "Gottis",
               address: "811 St Emanuel St",
               city: "Houston",
               state: "TX",
               zipCode: "77003",
               country: "USA",
               phoneNumber: "(713) 405-3500",
               email: "care@gottis.com",
               website: "https://eatgottis.com/",
               description: "A unique ambiance and dining experience with a fusion of Creole & Cajun tastes.",
               capacity: 120,
               amenities: ["Full Bar", "Live Music", "Outdoor Seating"],
            imageUrl: "https://firebasestorage.googleapis.com/v0/b/bookd-98e12.appspot.com/o/users%2Fsamplevenues%2Fimages.png?alt=media&token=b03db335-3ae6-4aa8-8574-95d53859ed04", bannerUrl: "https://firebasestorage.googleapis.com/v0/b/bookd-98e12.appspot.com/o/users%2Fsamplevenues%2Fhuge.jpg?alt=media&token=b64865d8-acf4-4c41-b39b-c4d52c119929",
               latitude: 29.7499,
               longitude: -95.3565,
               rating: 4.0,
               reviews: ["placeholder_review"],
               openingHours: ["Monday": "7:00 PM - 1:00 AM", "Tuesday": "11:00 AM - 12:00 AM", "Wednesday": "11:00 AM - 12:00 AM", "Thursday": "11:00 AM - 12:00 AM", "Friday": "11:00 AM - 12:00 AM", "Saturday": "11:00 AM - 12:00 AM", "Sunday": "11:00 AM - 12:00 AM"],
               events: ["placeholder_event"]
           ),
           VenueInfo(
            id: UUID(),
               name: "Kulture",
               address: "701 Avenida de Las Americas",
               city: "Houston",
               state: "TX",
               zipCode: "77010",
               country: "USA",
               phoneNumber: "(713) 357-9697",
               email: "info@kulturegrb.com",
               website: "https://www.opentable.com/r/kulture-restaurant-houston",
               description: "An innovative dining concept providing a national platform where Chefs share & create their take on the diaspora of Southern/African cultures.",
               capacity: 100,
               amenities: ["Full Bar", "Live Music", "Outdoor Seating"],
            imageUrl: "https://firebasestorage.googleapis.com/v0/b/bookd-98e12.appspot.com/o/users%2Fsamplevenues%2Fimages-2.jpeg?alt=media&token=dfcb78ae-0a0f-4eaa-aae1-874427846616", bannerUrl: "https://firebasestorage.googleapis.com/v0/b/bookd-98e12.appspot.com/o/users%2Fsamplevenues%2FrawImage.jpg?alt=media&token=a0de2739-4ed0-4189-8bc3-bd0ba731d408",
               latitude: 29.7523,
               longitude: -95.3570,
               rating: 4.6,
               reviews: ["placeholder_review"],
               openingHours: ["Wednesday": "11:30 AM - 3:00 PM", "Thursday": "11:30 AM - 3:00 PM", "Friday": "11:30 AM - 3:00 PM", "Saturday": "11:30 AM - 3:00 PM", "Sunday": "11:30 AM - 3:00 PM"],
               events: ["placeholder_event"]
           ),
           VenueInfo(
            id: UUID(),
               name: "4 Gents",
               address: "8650 N Sam Houston Pkwy E",
               city: "Humble",
               state: "TX",
               zipCode: "77396",
               country: "USA",
               phoneNumber: "(936) 320-1625",
               email: "4GentsCigarBar@gmail.com",
               website: "https://www.4gentscigarbar.com/",
               description: "An upscale cigar lounge with a full bar and a variety of cigars to choose from.",
               capacity: 80,
               amenities: ["Full Bar", "Cigar Lounge", "Outdoor Seating"],
            imageUrl: "https://firebasestorage.googleapis.com/v0/b/bookd-98e12.appspot.com/o/users%2Fsamplevenues%2Fimages-3.jpeg?alt=media&token=2cd43d6e-4e22-4253-9723-87537e93ecb2", bannerUrl: "https://firebasestorage.googleapis.com/v0/b/bookd-98e12.appspot.com/o/users%2Fsamplevenues%2F4-gents-cigar-bar_9689.jpeg?alt=media&token=43eeaa87-7368-48de-90b1-e11556afbfe5",
               latitude: 29.9375,
               longitude: -95.2653,
               rating: 4.2,
               reviews: ["placeholder_review"],
               openingHours: ["Thursday": "6:00 PM - 12:00 AM", "Sunday": "12:00 PM - 8:00 PM"],
               events: ["placeholder_event"]
           ),
           VenueInfo(
            id: UUID(),
               name: "Prospect Park",
               address: "3100 Fountain View Dr",
               city: "Houston",
               state: "TX",
               zipCode: "77057",
               country: "USA",
               phoneNumber: "(281) 853-5851",
               email: "N/A",
               website: "https://www.prospectparkrestaurants.com/",
               description: "A top of the line diner offering an exclusive bar and grill experience.",
               capacity: 200,
               amenities: ["Full Bar", "Live Music", "Outdoor Seating"],
            imageUrl: "https://firebasestorage.googleapis.com/v0/b/bookd-98e12.appspot.com/o/users%2Fsamplevenues%2Fimages-2.png?alt=media&token=991dd390-ecf8-4f31-8c4e-489087e6f748", bannerUrl: "https://firebasestorage.googleapis.com/v0/b/bookd-98e12.appspot.com/o/users%2Fsamplevenues%2F11889518_1477350249255918_768822876529236197_n0-947a073ae8ccc2a_947a0838-ac81-7ecd-1ffe3ed7985a1f8e.jpg?alt=media&token=86cb6058-7acd-4f5b-a9cf-39ae28fc1fc4",
               latitude: 29.7398,
               longitude: -95.4816,
               rating: 3.5,
               reviews: ["placeholder_review"],
               openingHours: ["Monday": "12:00 PM - 1:00 AM", "Tuesday": "12:00 PM - 1:00 AM", "Wednesday": "12:00 PM - 2:00 AM", "Thursday": "12:00 PM - 2:00 AM", "Friday": "12:00 PM - 2:00 AM", "Saturday": "11:00 AM - 2:00 AM", "Sunday": "11:00 AM - 1:00 AM"],
               events: ["placeholder_event"]
           ),
           VenueInfo(
            id: UUID(),
               name: "Qulture",
               address: "700 E Sonterra Blvd Ste 138",
               city: "San Antonio",
               state: "TX",
               zipCode: "78258",
               country: "USA",
               phoneNumber: "(210) 441-7080",
               email: "N/A",
               website: "https://qulturesatx.com/",
               description: "A perfect fusion of urban upscale dining and the vibrant energy of a modern lounge.",
               capacity: 150,
               amenities: ["Full Bar", "Live Music", "Outdoor Seating"],
            imageUrl: "https://firebasestorage.googleapis.com/v0/b/bookd-98e12.appspot.com/o/users%2Fsamplevenues%2Fimages-3.png?alt=media&token=a9701ec1-59ec-4f84-93f4-b78d7a274085", bannerUrl: "https://firebasestorage.googleapis.com/v0/b/bookd-98e12.appspot.com/o/users%2Fsamplevenues%2Fhuge-2.jpg?alt=media&token=9b6a79ab-416d-4175-8d1e-ccf72d6b677e",
               latitude: 29.7351,
               longitude: -95.4816,
               rating: 3.5,
               reviews:  ["placeholder"],
               openingHours: ["Monday": "12:00 PM - 1:00 AM", "Tuesday": "12:00 PM - 1:00 AM", "Wednesday": "12:00 PM - 2:00 AM", "Thursday": "12:00 PM - 2:00 AM", "Friday": "12:00 PM - 2:00 AM", "Saturday": "11:00 AM - 2:00 AM", "Sunday": "11:00 AM - 1:00 AM"],
            events: ["placeholder_event"]
            )
    ]
}

