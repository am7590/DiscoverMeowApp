//
//  SelectDateView.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/28/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import SwiftUI

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

struct SelectDateView_Previews: PreviewProvider {
    static var previews: some View {
        SelectDateView()
    }
}
