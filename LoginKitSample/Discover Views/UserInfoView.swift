//
//  UserInfoView.swift
//  DiscoverMeow
//
//  Created by Alek Michelson on 11/12/22.
//

import SwiftUI

struct UserInfoView: View {
    @StateObject var viewModel: DiscoverViewModel
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                let bitmojiSize = (proxy.size.width / 2) - 25
                HStack {
                    BitmojiDetailView(imageSize: .small)
                        .cornerRadius(20)
                        .frame(width: bitmojiSize, height: bitmojiSize)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .shadow(color: Color.yellow.opacity(0.2), radius: 5, x: 0, y: 2)
                    
                    VStack(alignment: .leading) {
                        Text("mushroom")
                            .font(.title)
                        //.frame(width: bitmojiSize)
                        //                            .padding(.horizontal, 8)
                        //                            .padding(.vertical, 2)
                        //                            .background(
                        //                                Capsule(style: .continuous)
                        //                                    .fill(Color("LightYellow"))
                        //                            )
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                            .shadow(color: Color.yellow.opacity(0.2), radius: 5, x: 0, y: 2)
                            .redacted(reason: .placeholder)
                        
                        Text("school status")
                            .font(.title3.bold())
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                            .shadow(color: Color.yellow.opacity(0.2), radius: 5, x: 0, y: 2)
                            .redacted(reason: .placeholder)
                        
                        
                        Text("🇺🇸 United States")
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                            .shadow(color: Color.yellow.opacity(0.2), radius: 5, x: 0, y: 2)
                            .font(.subheadline.bold())
                        
                        
                        FlexibleView(
                            availableWidth: bitmojiSize,
                            data: ["⚽️", "🎣", "🎤", "🏕"], // "👨‍🍳"
                            spacing: 4,
                            alignment: .leading
                        ) { item in
                            Text(verbatim: item)
                                .padding(2)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color("LightYellow"))
                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                        .shadow(color: Color.yellow.opacity(0.2), radius: 5, x: 0, y: 2)
                                )
                            
                        }
                        
                        Spacer()
                        
                    }
                }
                .frame(height: bitmojiSize)
                .padding([.top, .leading, .trailing])
                
            }
            
            
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("LightYellow"))
                .padding([.bottom, .leading, .trailing])
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                .shadow(color: Color.yellow.opacity(0.2), radius: 5, x: 0, y: 2)
            
            
            
            HStack {
                Image(systemName: "xmark")
                    .background(Circle().fill(.red)
                        .frame(width: 60, height: 60))
                    .padding(25)
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 2)
                    .shadow(color: Color.red.opacity(0.4), radius: 10, x: 0, y: 2)
                
                Spacer()
                
                Image(systemName: "checkmark")
                    .background(Circle().fill(Color("LightGreen"))
                        .frame(width: 60, height: 60))
                    .padding(25)
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 2)
                    .shadow(color: Color("LightGreen").opacity(0.4), radius: 10, x: 0, y: 2)
            }
            .padding(.horizontal, 48)
            
            Spacer()
            
        }
        .frame(width: 300, height: 400)
        //.background(Color.yellow)
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        .shadow(color: Color.yellow.opacity(0.2), radius: 5, x: 0, y: 2)
            
        
        .background(
            Rectangle()
                .fill(Color.white)
                .cornerRadius(12)
                .shadow(
                    color: Color.gray.opacity(0.8),
                    radius: 8,
                    x: 0,
                    y: 0
                )
        )
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(viewModel: DiscoverViewModel())
    }
}
