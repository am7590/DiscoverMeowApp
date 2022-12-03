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
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("LightYellow"))
                            .padding()
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                            .shadow(color: Color.yellow.opacity(0.2), radius: 5, x: 0, y: 2)
                        
                        if let user = viewModel.selectedUser {
                            
                            HStack {
                                
                                VStack {
                                    
                                    
                                    BitmojiDetailViewFromURL(imageSize: .large, selectedUser: user)
                                        .cornerRadius(20)
                                        .frame(width: bitmojiSize, height: bitmojiSize)
                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                        .shadow(color: Color.yellow.opacity(0.2), radius: 5, x: 0, y: 2)
                                    
                                    
                                    
                                    //                                BitmojiDetailView(imageSize: .large)
                                    
                                    
                                    Spacer()
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("mushroom")
                                        .font(.largeTitle)
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
                                        .font(.title2.bold())
                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                        .shadow(color: Color.yellow.opacity(0.2), radius: 5, x: 0, y: 2)
                                        .redacted(reason: .placeholder)
                                    
                                    Group {
                                        Text(" \((user.country ?? "US").flag())")
                                        + Text(" \((user.country ?? "US").countryName())")
                                    }
                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                        .shadow(color: Color.yellow.opacity(0.2), radius: 5, x: 0, y: 2)
                                        .font(.title3.bold())
                                    
                                    FlexibleView(
                                        availableWidth: bitmojiSize,
                                        data: ["⚽️", "🎣", "🎤", "🏕"], // "👨‍🍳"
                                        spacing: 8,
                                        alignment: .leading
                                    ) { item in
                                        Text(verbatim: item)
                                            .padding(4)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color("LightYellow"))
                                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                                    .shadow(color: Color.yellow.opacity(0.2), radius: 5, x: 0, y: 2)
                                            )
                                    }
                                    
                                    Spacer()
                                    
                                }
                            }.padding([.top, .leading, .trailing])
                        }
                    }
                }
            }
            
            HStack {
                Image(systemName: "xmark")
                    .background(Circle().fill(.red)
                        .frame(width: 70, height: 70))
                    .padding(25)
                    .padding(.bottom, 10)
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 2)
                    .shadow(color: Color.red.opacity(0.4), radius: 10, x: 0, y: 2)
                    .onTapGesture {
                        print("swipe left")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                            withAnimation(.default){
                                viewModel.showSelectedBitmoji = false
                            }
                        })
                    }
                
                Spacer()
                
                Image(systemName: "checkmark")
                    .background(Circle().fill(.teal)
                        .frame(width: 70, height: 70))
                    .padding(25)
                    .padding(.bottom, 10)
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 2)
                    .shadow(color: Color("LightGreen").opacity(0.4), radius: 10, x: 0, y: 2)
                 
                    .onTapGesture {
                        print("swipe right")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            viewModel.triggerConfetti()

                            withAnimation(.default){
                                viewModel.showSelectedBitmoji = false
                            }
                        })
                    }
            }
            .padding(.horizontal, 48)
            
            Spacer()
        }
        .frame(height: 400)
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
        .padding()
        //        .modifier(SwipeToDismissModifier(onDismiss: {
        //            print("swipe")
        //        }))
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(viewModel: DiscoverViewModel())
    }
}
