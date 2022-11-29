//
//  PreferencesView.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/28/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import SwiftUI


struct PreferencesView: View {
    
    @State private var isActive = false
    
    var body: some View {
        VStack {
            Spacer()
            
            FlexibleView(
                availableWidth: UIScreen.main.bounds.width-16,
                data: ["⚽️", "🎣", "🎤", "🏕", "👨‍🍳", "⚽️", "🎣", "🎤", "🏕", "👨‍🍳", "⚽️", "🎣", "🎤", "🏕", "👨‍🍳", "..."],
                spacing: 12,
                alignment: .leading
            ) { item in
                
                Text(verbatim: item)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("LightYellow"))
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                            .shadow(color: Color.yellow.opacity(0.2), radius: 5, x: 0, y: 2)
                    )
            }
            //.frame(width: UIScreen.main.bounds.width, height: 40)
            .padding(.vertical)
            
            
            Group {
                Group {
                    Text("Done")
                        .bold()
                }
                .font(.title3)
                .frame(width: 250, height: 40)
                .background(.red)
                .clipShape(Capsule())
            }
            .onTapGesture {
                isActive = true
            }
            .padding(.top, 50)
            .fullScreenCover(isPresented: self.$isActive, content: {
                DiscoverView()
            })
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
