//
//  OnboardingArrowView.swift
//  DiscoverMeowOnboarding
//
//  Created by Alek Michelson on 11/5/22.
//

import SwiftUI

enum OnboardingArrow {
    case right, left, both
}

struct OnboardingArrowView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    var arrow: OnboardingArrow
    
    var body: some View {
        switch arrow {
        case .right:
            HStack {
                Spacer()
                rightArrow
            }
        case .left:
            HStack {
                leftArrow
                Spacer()
            }
        case .both:
            bothArrows
        }
    }
}

extension OnboardingArrowView {
    
    struct Constants {
        static let rightArrow = "arrow.right"
        static let leftArrow = "arrow.left"
    }
    
    @ViewBuilder
    public var rightArrow: some View {
        Image(systemName: Constants.rightArrow)
            .onboardingButton()
            .onTapGesture {
                viewModel.incrementPage()
            }
    }
    
    @ViewBuilder
    public var leftArrow: some View {
        Image(systemName: Constants.leftArrow)
            .onboardingButton()
            .onTapGesture {
                viewModel.decrementPage()
            }
    }
    
    @ViewBuilder
    public var bothArrows: some View {
        HStack {
            leftArrow
            Spacer()
            rightArrow
        }
    }
}


// MARK: Button modifier

struct OnboardingButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Circle().fill(Color("blue"))
                .frame(width: 65, height: 65))
            .padding(50)
    }
}

extension View {
    func onboardingButton() -> some View {
        modifier(OnboardingButtonModifier())
    }
}

