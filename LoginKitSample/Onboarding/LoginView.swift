//
//  LoginView.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/17/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import SwiftUI
import SCSDKLoginKit

struct LoginView: View {
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width/1.75
            VStack(spacing: 10) {
                Image("logo")
                        .resizable()
                        .scaledToFit()
                        .padding(100)
                
                Text("Welcome to DiscoverMeow")
                    .font(.title.bold())
                
                Text("this is a cool slogan")
                    .font(.title3)
                    .frame(width: 300)
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    ZStack {
                        Capsule()
                            .fill(Color("LightYellow"))
                            .frame(width: 200, height: 45)
                            .padding(10)
                        Text("Login with Snapchat")
                            .font(.headline.bold())
                            .foregroundColor(.primary)

                    }
                    
                })
                
                
                Spacer()
                
            }
        }
       
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
