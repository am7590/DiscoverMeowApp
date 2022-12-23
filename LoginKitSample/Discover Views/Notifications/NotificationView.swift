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
    @StateObject var viewModel: NotificationViewModel

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    ExitButtonView(title: "Requests", dismissAction: {
                        dismiss()
                    })
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                ScrollView {
                    ForEach(viewModel.matchedUsers, id: \.bitmojiURL) { user in
                        let userDisplayName = DatabaseManager.shared.user?.displayName

                        RequestCellView(request: Request(user: user, message: "Placeholder text"))
                        
//                        if ((user.swipeRightList?.contains(where: {$0.displayName == userDisplayName})) != nil) {
//                            RequestCellView(request: Request(user: user, message: "Placeholder message"))
//                                .redacted(reason: .placeholder)
//                        } else {
//                            RequestCellView(request: Request(user: user, message: "Placeholder message"))
//                        }
 
                    }.padding(.bottom)
                    
                    ForEach(viewModel.blurredUsers, id: \.bitmojiURL) { user in
                        let userDisplayName = DatabaseManager.shared.user?.displayName

                        RequestCellView(request: Request(user: user, message: user.requestMessage ?? "Add me on Snap"))
                            .redacted(reason: .placeholder)

                    }.padding(.bottom)
                }
            }
        }
        .onAppear {
            viewModel.fetchMatchList()
            viewModel.fetchNonMatchList()
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(viewModel: NotificationViewModel())
    }
}
