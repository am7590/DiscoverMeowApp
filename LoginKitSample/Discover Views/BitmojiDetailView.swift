//
//  BitmojiDetailView.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/19/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import SwiftUI

enum ImageSize {
    case small, large
}

struct BitmojiDetailView: View {
    var imageSize: ImageSize
    
    var body: some View {
        ZStack {
            VStack {
                //                Image("alek")
                //                    .resizable()
                //                    .scaledToFit()
                //Text(user.name)
                
                AsyncImage(
                    url: DatabaseManager.shared.user?.bitmojiURL,
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            
                            //.background(Circle().frame(width: imageSize == .large ? 205 : 0, height: imageSize == .large ? 205 : 0))
                    },
                    placeholder: {
                        ProgressView()
                    })
                .frame(maxWidth: imageSize == .large ? 200 : 50, maxHeight: imageSize == .large ? 200 : 50)
                .foregroundColor(imageSize == .large ? .blue : .clear)
            }
        }
    }
}
