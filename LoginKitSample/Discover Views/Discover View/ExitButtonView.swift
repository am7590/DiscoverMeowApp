//
//  ExitButtonView.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 12/22/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import SwiftUI

struct ExitButtonView: View {
    var title: String?
    var dismissAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                dismissAction()
            }, label: {
                Image(systemName: "arrowshape.turn.up.backward.fill")
                    .resizable()
                    .foregroundColor(.yellow)
                    .frame(width: 25, height: 25)
                    .padding([.leading, .trailing, .top])
            })
            
            if let title = title {
                Spacer()
                
                Text(title)
                    .font(.largeTitle.bold())
                    .padding(.top)
                
                Spacer()
            }
            
            Spacer()
        }
    }
}

struct ExitButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ExitButtonView(title: "Requests", dismissAction: {
            print("dismiss")
        })
    }
}
