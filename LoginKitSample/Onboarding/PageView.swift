//
//  PageView.swift
//  DiscoverMeowOnboarding
//
//  Created by Alek Michelson on 11/5/22.
//

import SwiftUI

struct PageView: View {
    var page: Page
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width/1.75
            VStack(spacing: 10) {
                if let image = page.image {
                    Image("\(image)")
                        .resizable()
                        .scaledToFit()
                        .padding(70)
                }
                
                Text(page.title)
                    .font(.title.bold())
                
                Text(page.description)
                    .font(.title3)
                    .frame(width: 300)
                
                page.bodyView
                    .padding()
                
                Spacer()
                
            }
        }
       
    }
}


// MARK: Previews

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(page: Page.welcome)
    }
}
