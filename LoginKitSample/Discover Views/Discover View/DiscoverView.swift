//
//  DiscoverView.swift
//  DiscoverMeowApp
//
//  Created by Alek Michelson on 11/17/22.
//  Copyright © 2022 Alek. All rights reserved.
//

import ConfettiSwiftUI
import SwiftUI

struct DiscoverView: View {
    
    @StateObject var viewModel: DiscoverViewModel
    @State private var showProfileView = false
    @State private var showNotificationView = false
    
    let bitmojiColumns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 2)
    let bitmojiColumnWidth = (UIScreen.main.bounds.width - 45) / 2
    @Namespace var dragAnimation
    
    var body: some View {
        
        ZStack {
            if viewModel.showSelectedBitmoji {
                showDetailView()
            }
            
            VStack {
                ScrollView {
                    HStack {
                        Button {
                            self.showProfileView.toggle()
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
                            self.showNotificationView.toggle()
                        } label: {
                            Image(systemName: "bell")
                                .font(.title.bold())
                                .foregroundColor(.black)
                        }
                        
                        
                    }
                    .padding(.horizontal)
                    
                    
                    LazyVGrid(columns: bitmojiColumns, spacing: 8, content: {
                        ForEach(viewModel.users, id:\.token) { user in
                            
                            BitmojiDummyDetailView(bitmojiURL: user.bitmojiURL)
                                .cornerRadius(30)
                                .onTapGesture {
                                    viewModel.showSelectedBitmoji = true
                                    viewModel.selectedUser = user
                                }
                        }
                       
                    })
                    .padding()
                    
                }
            }
        }
        .sheet(isPresented: $showProfileView) {
            ProfileView()
        }
        .sheet(isPresented: $showNotificationView) {
            NotificationView(viewModel: NotificationViewModel())
        }
        .confettiCannon(counter: $viewModel.swipeCount, num: 50, colors: [.yellow, .orange], openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 200)
        .onAppear {
            viewModel.loadUsers()
        }
    }
}

extension DiscoverView {
    
    @ViewBuilder func showDetailView() -> some View {
            ZStack {
                Color.black.opacity(0.75)
        
                ZStack {
                    VStack {
                        UserInfoView(viewModel: viewModel)
                            .onTapGesture {
                                withAnimation(.default) {
                                    viewModel.showSelectedBitmoji = false
                                    viewModel.offset = .zero
                                    viewModel.scale = 1
                                }
                            }
                            .matchedGeometryEffect(id: viewModel.selectedBitmoji.id, in: dragAnimation)
                            .modifier(SwipeToDismissModifier(onDismiss: { swipe in
                                print("swiped \(swipe ? "right" : "left")")
                                
                                if swipe {
                                    viewModel.triggerConfetti()
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                                    withAnimation(.default){
                                        viewModel.showSelectedBitmoji = false
                                    }
                                })
                            }))
                        
                    }
                }
        
        
            }.ignoresSafeArea(.all, edges: .all)
                .zIndex(3)
    }
    

    
    func onChanged(dragValue: DragGesture.Value){
        if dragValue.translation.height > 0 {
            viewModel.offset = dragValue.translation
            let progress = viewModel.offset.height / UIScreen.main.bounds.height
            
            if 1 - progress > 0.5 {
                viewModel.scale = 1 - progress
            }
        }
    }
    
    func exitDetailView(value: DragGesture.Value) {
        withAnimation(.default){
            viewModel.showSelectedBitmoji = false
            viewModel.offset = .zero
            viewModel.scale = 1
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView(viewModel: DiscoverViewModel())
    }
}


struct BitmojiDummyDetailView: View {
    let bitmojiURL: URL
    
    var body: some View {
        ZStack {
            VStack {
                AsyncImage(
                    url: bitmojiURL,
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 150, maxHeight: 150)
                            .background(RoundedRectangle(cornerRadius: 8)
                                .fill(Color("LightYellow"))
                                .frame(width: 152, height: 152))
                    },
                    placeholder: {
                        ProgressView()
                    })
            }
        }
    }
}
