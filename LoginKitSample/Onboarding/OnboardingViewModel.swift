//
//  OnboardingViewModel.swift
//  DiscoverMeowOnboarding
//
//  Created by Alek Michelson on 11/5/22.
//

import SwiftUI

@MainActor class OnboardingViewModel: ObservableObject {
    @Published var pageIndex = 0
    let pages: [Page] = DummyData.onboardingViews

    let dotAppearance = UIPageControl.appearance()
    
    func setupDotAppearance() {
        dotAppearance.currentPageIndicatorTintColor = .black
        dotAppearance.pageIndicatorTintColor = .gray
    }
    
    func incrementPage() {
        self.pageIndex += 1
    }
    
    func decrementPage() {
        self.pageIndex -= 1
    }
}
