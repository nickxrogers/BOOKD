//
//  Schema.swift
//  BOOKD
//
//  Created by Nick Rogers on 8/8/24.
//

import Foundation
import SwiftUI
import BottomSheet

enum SheetExampleTypes {
    case home
    case stocks
    case staticScrollView
}

class SheetSettings: ObservableObject {
    @Published var isPresented = true
    @Published var activeSheetType: SheetExampleTypes = .stocks
    @Published var selectedDetent: BottomSheet.PresentationDetent = .medium
    @Published var translation: CGFloat = BottomSheet.PresentationDetent.medium.size
}

enum bgElement {
    case ultraThinMaterial
    case thinMaterial
    case regularMaterial
    case thickMaterial
    case ultraThickMaterial
}

enum onboardingNavigation: String, Hashable {
    case login = "login"
    case signUp = "signup"
    case onboarding
}
