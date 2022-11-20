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
    
    var transitionToDiscoverView: Bool {
        if case .preferences = self {
            return true
        } else {
            return false
        }
    }
}


// MARK: Dummy views

struct SelectDateView: View {
    @State private var birthDate = Date()
    @State private var age: DateComponents = DateComponents()
    
    var body: some View {
        VStack {
            Spacer()
            
            DatePicker("", selection: $birthDate, in: ...Date(), displayedComponents: .date).datePickerStyle(WheelDatePickerStyle()).font(.title)
                .onChange(of: birthDate, perform: { value in
                    age = Calendar.current.dateComponents([.year, .month, .day], from: birthDate, to: Date())
                })
            Text("Please confirm you are \(age.year ?? 0) years old")
                .font(.title3)
            
            Spacer()
        }
        .background(Color("MeowOrange"))
    }
}


struct SelectCountryView: View {
    @State var countryId: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            CountryPicker(countryId: $countryId)
            Text("You picked \(countryId) \(flag(countryId))")
            Spacer()
        }
        .background(Color("MeowOrange"))
        .frame(width: UIScreen.main.bounds.width)
    }
   
    func flag(_ country: String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}

struct CountryPicker: View {
    @Binding var countryId: String
    @Environment(\.locale) var locale
    
    var body: some View {
        Picker("", selection: $countryId) {
            ForEach(Locale.isoRegionCodes, id: \.self) { iso in
                Text(locale.localizedString(forRegionCode: iso)!)
                    .tag(iso)
            }
        }
    }
}

struct PreferencesView: View {
    
    @State private var isActive = false
    
    var body: some View {
        VStack {
            Spacer()
            
//            FlexibleView(
//                availableWidth: UIScreen.main.bounds.width-16,
//                data: ["⚽️", "🎣", "🎤", "🏕", "👨‍🍳", "⚽️", "🎣", "🎤", "🏕", "👨‍🍳", "⚽️", "🎣", "🎤", "🏕", "👨‍🍳", "..."],
//                spacing: 12,
//                alignment: .leading
//            ) { item in
//                
//                Text(verbatim: item)
//                    .padding(12)
//                    .background(
//                        RoundedRectangle(cornerRadius: 8)
//                            .fill(Color("LightYellow"))
//                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
//                            .shadow(color: Color.yellow.opacity(0.2), radius: 5, x: 0, y: 2)
//                    )
//            }
//            .frame(width: UIScreen.main.bounds.width, height: 40)
//            .padding(.vertical)
            
            
            Group {
                Group {
                    Text("Done")
                        .bold()
                }
                .font(.title3)
                .frame(width: 250)
                .background(.red)
                .clipShape(Capsule())
            }
            .onTapGesture {
                isActive = true
            }
            padding(.top, 50)
            
            NavigationLink(destination: DiscoverView(), isActive: $isActive) { }
                .isDetailLink(false)
            
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}
