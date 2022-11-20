//
//  MainOnboardingView.swift
//  DiscoverMeowOnboarding
//
//  Created by Alek Michelson on 11/5/22.
//

import SwiftUI

struct MainOnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        NavigationView {
            TabView(selection: $viewModel.pageIndex) {
                ForEach(viewModel.pages) { page in
                    VStack {
                        Spacer()
                        PageView(page: page)
                        Spacer()
                        OnboardingArrowView(viewModel: viewModel, arrow: page.arrowConfig)
                            .onTapGesture {
                                viewModel.incrementPage()
                            }
                        Spacer()
                    }
                    .tag(page.tag)
                }
            }
            .animation(.default, value: viewModel.pageIndex)
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .tabViewStyle(PageTabViewStyle())
            .onAppear {
                viewModel.setupDotAppearance()
            }
            .background(Color("MeowOrange"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
//        .background(
//            RadialGradient(gradient: Gradient(colors: [.orange, .white]), center: .center, startRadius: 0, endRadius: 400)
//            )
        
        
    }
}

struct MainOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        MainOnboardingView(viewModel: OnboardingViewModel())
    }
}
