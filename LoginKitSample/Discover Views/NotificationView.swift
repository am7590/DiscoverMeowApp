//
//  NotificationView.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/20/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import SwiftUI

struct NotificationView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Capsule()
                            .fill(.yellow)
                            .frame(width: 45, height: 6)
                            .padding(10)
                    })
                }
                
                HStack {
                    Text("Requests")
                        .font(.largeTitle.bold())
                    Spacer()
                }
                .padding(.horizontal)
                
                let fakeUser = User(displayName: "Name", bitmojiURL: DatabaseManager.shared.user!.bitmojiURL, token: "")
                let fakeRequest = Request(user: fakeUser, message: "Lets be friends")
                
                ScrollView {
                    RequestCellView(request: fakeRequest)
                    
                    RequestCellView(request: fakeRequest)
                    
                    RequestCellView(request: fakeRequest)
                        .redacted(reason: .placeholder)
                    
                    RequestCellView(request: fakeRequest)
                        .redacted(reason: .placeholder)
                }
                
       
                
                Spacer()

            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
