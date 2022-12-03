//
//  SwipeToDismissModifier.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 12/1/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import ConfettiSwiftUI
import SwiftUI

struct SwipeToDismissModifier: ViewModifier {
    var onDismiss: (Bool) -> Void   /// Returns true if right swipe, false if left swipe
    @State private var offset: CGSize = .zero    

    func body(content: Content) -> some View {
        content
            .offset(x: offset.width)
            .animation(.interactiveSpring(), value: offset)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width < 250 {
                            offset = gesture.translation
                        }
                    }
                    .onEnded { _ in
                        if abs(offset.width) > 100 {
                            if offset.width.isLess(than: 0) {
                                onDismiss(false)
                            } else {
                                onDismiss(true)
                            }
                        }
                    }
            )
    }
}
