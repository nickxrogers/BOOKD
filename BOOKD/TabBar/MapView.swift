//
//  MapView.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/6/24.
//

import SwiftUI
import MapKit
import CoreLocation
import BottomSheet
import Combine

class MapSheetSettings: ObservableObject {
    @Published var isPresented = true
    @Published var activeSheetType: SheetExampleTypes = .stocks
    @Published var selectedDetent: BottomSheet.PresentationDetent = .medium
    @Published var translation: CGFloat = BottomSheet.PresentationDetent.medium.size
}

struct MapView: View {
    @StateObject var settings = MapSheetSettings()
    @State var camera: MapCameraPosition = .userLocation(fallback: .automatic)
    @StateObject var venueStore = SampleVenuesList()
    @State var expand = false
    @StateObject var locationManager = LocationManager()
    @State private var selectedLocation: CLLocationCoordinate2D? = nil
    @State private var selectedTag: UUID? // Change to UUID
    @State private var filteredVenues: [VenueInfo] = []
    
    let radius: CLLocationDistance = 50000 // 50 km radius
    
    private func filterVenues() {
           guard let userLocation = locationManager.userLocation else { return }
           
           filteredVenues = venueStore.venues.filter { venue in
               let venueLocation = CLLocation(latitude: venue.latitude, longitude: venue.longitude)
               let userLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
               
               let distance = venueLocation.distance(from: userLocation)
               return distance <= radius
           }
        print("filterd")
       }
       
       var selectedVenue: VenueInfo? {
            if let selectedTag = selectedTag {
                return venueStore.venues.first { $0.id == selectedTag } // Compare UUID with UUID
            }
            return nil
        }


    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(position: $camera, selection: $selectedTag) {
                ForEach(filteredVenues) { location in
                    Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                        .tag(location.id)
                        
                        
                }
            }
            
            
            ExpandingSheet(
                expand: $expand,
                venue: selectedVenue ?? venueStore.venues.first!
            )
            .shadow(radius: 10)

            .safeAreaPadding(.top)
            .navigationBarHidden(true)
        } // Hides the navigation bar
        .onAppear {
            // Start location updates when the view appears
            locationManager.startLocationUpdates()
            filterVenues()
        }
    }
}

#Preview {
    MapView()
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocationCoordinate2D?
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        startLocationUpdates()
    }
    
    func startLocationUpdates() {
        locationManager.startUpdatingLocation()
    }

    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            DispatchQueue.main.async {
                self.userLocation = location.coordinate
                // Stop updating location after getting the initial location
                self.stopLocationUpdates()
            }
        }
    }
}
