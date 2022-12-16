//
//  YouMatchedView.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 12/7/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import SwiftUI

struct YouMatchedView: View {
    let selectedUser: User
    @State var message: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Button(action: {
                dismiss()
            }, label: {
                Capsule()
                    .fill(.yellow)
                    .frame(width: 45, height: 6)
                    .padding(10)
            })
            
            Text("You matched with")
                .font(.title2)
                .bold()
            
            HStack {
                AsyncImage(
                    url: selectedUser.bitmojiURL,
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 160, maxHeight: 160)
                    },
                    placeholder: {
                        ProgressView()
                    })
               
                VStack(alignment: .leading) {
                    
                    Text(selectedUser.displayName)
                        .font(.system(size: 42, design: .rounded).bold())
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    
                    // "🇺🇸 United States"
                    Group {
                        Text("\((selectedUser.country ?? "US").flag())")
                        + Text(" \((selectedUser.country ?? "US").countryName())")
                    }
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .shadow(color: Color.yellow.opacity(0.2), radius: 5, x: 0, y: 2)
                        .font(.title2.bold())
                    
                }
                .padding()
                
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("Message: ")
                    .font(.title2)
                    .bold()
                
                TextField("Add me on snapchat", text: $message)
                    .font(.title)
            }
            .padding()
            
            HStack {
                Spacer()
                
                Group {
                    Text("Exit")
                        .bold()
                }
                .font(.title3)
                .padding()
                .frame(width: 150, height: 35)
                .background(.red)
                .clipShape(Capsule())
                .onTapGesture {
                    dismiss()
                }
                
                
                
                
                Spacer()
                
          
                Group {
                    Text("Send")
                        .bold()
                }
                .font(.title3)
                .padding()
                .frame(width: 150, height: 35)
                .background(.yellow)
                .clipShape(Capsule())
                .onTapGesture {
                    DatabaseManager.shared.removeUserFromList(field: "otherUserSwipedList", user: selectedUser.getListUser(message), reference: UserDefaultsStorageManager.shared.getUserReferenceDocumentID()!)
                    DatabaseManager.shared.addUserToList(field: "matchList", user: UserDefaultsStorageManager.shared.cachedUser!.getListUser(), reference: selectedUser.id!)
                    DatabaseManager.shared.addUserToList(field: "matchList", user: (self.selectedUser.getListUser(message)), reference: UserDefaultsStorageManager.shared.getUserReferenceDocumentID()!)
                    DatabaseManager.shared.removeUserFromList(field: "otherUserSwipedList", user: (self.selectedUser.getListUser()), reference: UserDefaultsStorageManager.shared.getUserReferenceDocumentID()!)
                }
                
                Spacer()
            }
            .padding()
        }
        .padding(.vertical, 16)
        
//        .background(
//            Rectangle()
//                .fill(Color.white)
//                .cornerRadius(12)
//                .shadow(
//                    color: Color.gray.opacity(0.8),
//                    radius: 8,
//                    x: 0,
//                    y: 0
//                )
//        )
    }
}

struct YouMatchedView_Previews: PreviewProvider {
    static var previews: some View {
        YouMatchedView(selectedUser: User(displayName: "Alek", bitmojiURL: URL(string: "url")!, token: "token"))
    }
}
