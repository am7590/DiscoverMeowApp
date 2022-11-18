//
//  Page.swift
//  DiscoverMeowOnboarding
//
//  Created by Alek Michelson on 11/5/22.
//

import SwiftUI

enum Page: Identifiable, Equatable {
    case welcome, connectToSnap, verification
    
    var id: UUID { UUID() }
    
    var title: String {
        switch self {
        case .welcome:
            return "Welcome to DiscoverMeow"
        case .connectToSnap:
            return "Create a profile"
        case .verification:
            return "Verification"
        }
    }
    
    var description: String {
        switch self {
        case .welcome:
            return "Grow your snapchat following"
        case .connectToSnap:
            return "connectToSnap description"
        case .verification:
            return "verification description"
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
            return AnyView(red)
        case .verification:
            return AnyView(yellow)
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
        }
    }
    
    var arrowConfig: OnboardingArrow {
        switch self {
        case .welcome:
            return .right
        case .connectToSnap:
            return .both
        case .verification:
            return .left
        }
    }
}


// MARK: Dummy views

@ViewBuilder
public var red: some View {
    ZStack {
        Color.red
        
        VStack(spacing: 8) {
            Text("Connect to snapchat")
            Text("Verify bitmoji")
            Text("Verify age??")
        }
    }
}

@ViewBuilder
public var green: some View {
    ZStack {
        Color.green
    }
}

@ViewBuilder
public var yellow: some View {
    ZStack {
        Color.yellow
        
        VStack(spacing: 8) {
            Text("Make profile")
            Text("Edit name?")
            Text("Select interests")
        }
    }
}
