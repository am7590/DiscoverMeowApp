//
//  SelectCountryView.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/28/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import SwiftUI

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

struct SelectCountryView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCountryView()
    }
}