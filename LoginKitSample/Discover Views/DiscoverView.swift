//
//  DiscoverView.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/17/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import SwiftUI

struct DiscoverView: View {
    
    @StateObject private var viewModel = DiscoverViewModel()
    
    var body: some View {
        
        VStack {
            ScrollView {
                HStack {
                    Button {
                        // do something
                    } label: {
                        AsyncImage(
                            url: viewModel.bitmojiURL,
                            content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 45, maxHeight: 45)
                                    .background(Circle().frame(width: 48, height: 48))
                            },
                            placeholder: {
                                ProgressView()
                            })
                    }
                    
                    Spacer()

                    Button {
                        // do something
                    } label: {
                        Image(systemName: "bell")
                            .font(.title.bold())
                            .foregroundColor(.black)
                    }
                    
                }
                .padding(.horizontal)
                
                
                Text("Discover View")

            }
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
