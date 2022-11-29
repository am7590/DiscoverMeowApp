//
//  Page.swift
//  DiscoverMeowOnboarding
//
//  Created by Alek Michelson on 11/5/22.
//

import SwiftUI

enum Page: Identifiable, Equatable {
    case welcome, connectToSnap, verification, preferences
    
    var id: UUID { UUID() }
    
    var title: String {
        switch self {
        case .welcome:
            return "Welcome to DiscoverMeow"
        case .connectToSnap:
            return "What is your age?"
        case .verification:
            return "Where are you from?"
        case .preferences:
            return "Select your interests"
        }
    }
    
    var description: String {
        switch self {
        case .welcome:
            return "Grow your snapchat following"
        case .connectToSnap:
            return ""
        case .verification:
            return "Enter your country"
        case .preferences:
            return "I will remake this view"
        }
    }
    
    var image: String? {
        switch self {
        case .welcome:
            return "logo"
        default:
            return nil
        }
    }
    
    var bodyView: some View {
        switch self {
        case .welcome:
            return AnyView(EmptyView())
        case .connectToSnap:
            return AnyView(SelectDateView())
        case .verification:
            return AnyView(SelectCountryView())
        case .preferences:
            return AnyView(PreferencesView())
        }
    }
    
    var tag: Int {
        switch self {
        case .welcome:
            return 0
        case .connectToSnap:
            return 1
        case .verification:
            return 2
        case .preferences:
            return 3
        }
    }
    
    var arrowConfig: OnboardingArrow {
        switch self {
        case .welcome:
            return .right
        case .connectToSnap:
            return .both
        case .verification:
            return .both
        case .preferences:
            return .left
        }
    }
}
