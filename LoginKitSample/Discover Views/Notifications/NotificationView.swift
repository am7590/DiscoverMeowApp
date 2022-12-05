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
                
                ScrollView {
                    ForEach(viewModel.users, id: \.bitmojiURL) { user in
                        RequestCellView(request: Request(user: user, message: "Placeholder message"))
                    }.padding(.bottom)
                }
                
                
            }
        }
        .onAppear {
            viewModel.fetchSwipeList()
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(viewModel: NotificationViewModel())
    }
}
