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
    var onDismiss: () -> Void
    @State private var offset: CGSize = .zero
    @State private var counter: Int = 0
    

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
                                print("swipe left")
                            } else {
                                counter += 1
                                print("swipe right")
                            }
                            
                            onDismiss()
                        }
                    }
            )
            .confettiCannon(counter: $counter, num: 50, colors: [.yellow, .orange], openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 200)
    }
}
