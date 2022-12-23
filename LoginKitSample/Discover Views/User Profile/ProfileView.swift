//
//  ProfileView.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/19/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            
            ScrollView {
                VStack {
                    ExitButtonView(dismissAction: {
                        dismiss()
                    })
                    
                    BitmojiDetailView(imageSize: .large)
                        .frame(width: width/1.25)
                    
                    
                    Spacer()
                }
                .frame(width: width)
                
                Text(DatabaseManager.shared.user?.displayName ?? "")
                    .font(.system(size: 34, design: .rounded).bold())
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                
                // "🇺🇸 United States"
                Group {
                    Text(" \((DatabaseManager.shared.user?.country ?? "US").flag())")
                    + Text(" \((DatabaseManager.shared.user?.country ?? "US").countryName())")
                }
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    .shadow(color: Color.yellow.opacity(0.2), radius: 5, x: 0, y: 2)
                    .font(.title3.bold())
                
                HStack {
                    Text("Score   \(0)")
                        .font(.system(size: 20, design: .rounded).bold())
                        .frame(width: 150)
                        .padding(.vertical)
                        .background(.yellow.opacity(0.6))
                        .clipShape(Capsule())
                    
                    Text("Crickets   \(0)")
                        .font(.system(size: 20, design: .rounded).bold())
                        .frame(width: 150)
                        .padding(.vertical)
                        .background(.yellow.opacity(0.6))
                        .clipShape(Capsule())
                    
                }
                
                HStack {
                    Spacer()
                    
                    FlexibleView(
                        availableWidth: width/1.25,
                        data: ["⚽️", "🎣", "🎤", "🏕", "+"], // "👨‍🍳"
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
                    .frame(width: width/1.25, height: 40)
                    .padding(.vertical)
                    
                    Spacer()
                }
                
                Form {
                    Section(header:
                                HStack {
                        Text("Upgrade")
                            .foregroundColor(.black)
                            .font(.system(size: 20, design: .rounded).bold())
                        Spacer()
                        Text("Plus")   .font(.system(size: 20, design: .rounded).bold())
                        Spacer()
                        Text("Ultra")   .font(.system(size: 20, design: .rounded).bold())
                        Spacer()
                    }
                            
                    ) {
                        
                        // TODO: This will be refactored...
                        Group {
                            HStack {
                                Group {
                                    Text(Image(systemName: "bolt.fill")).bold() + Text(" Perk 1")
                                }
                                .foregroundColor(.secondary)
                                   
                                Spacer()
                                
                                Image(systemName: "xmark")
                                    .padding(.trailing, 75)
                                
                                Image(systemName: "checkmark")
                                    .bold()
                                Spacer()
                            }
                            
                            HStack {
                                Group {
                                    Text(Image(systemName: "nosign")).bold() + Text(" Perk 2")
                                        
                                }
                                .foregroundColor(.secondary)
                                   
                                Spacer()
                                
                                Image(systemName: "checkmark")
                                    .padding(.trailing, 75)
                                    .bold()
                                
                                Image(systemName: "checkmark")
                                    .bold()
                                
                                Spacer()
                            }
                            
                            HStack {
                                Group {
                                    Text(Image(systemName: "sparkles")) + Text(" Perk 3")
                                }
                                .foregroundColor(.secondary)
                                   
                                Spacer()
                                
                                Image(systemName: "checkmark")
                                    .padding(.trailing, 75)
                                    .bold()
                                
                                Image(systemName: "checkmark")
                                    .bold()
                                
                                Spacer()
                            }
                        }
                        
                        .font(.title3)
                        .frame(height: 40)
                    }
                }
                .frame(height: 270)
                
                Group {
                    Text(Image(systemName: "gear"))
                    + Text(" Settings")
                        .bold()
                }
                .font(.title3)
                .padding()
                .frame(width: 250)
                .background(.yellow)
                .clipShape(Capsule())
                
                Group {
                    Group {
                        Text("Log out")
                            .bold()
                    }
                    .font(.title3)
                    .padding()
                    .frame(width: 250)
                    .background(.red)
                    .clipShape(Capsule())
                }
                .padding(.top, 8)

 
            }.background(Color(.systemGroupedBackground))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
