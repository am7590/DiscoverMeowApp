//
//  ExitButtonView.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 12/22/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import SwiftUI

struct ExitButtonView: View {
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
            
            Spacer()
        }
    }
}
