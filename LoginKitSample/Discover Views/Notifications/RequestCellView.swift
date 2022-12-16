//
//  RequestCellView.swift
//  DiscoverMeow
//
//  Created by Alek Michelson on 11/14/22.
//

import SwiftUI

struct Request: Codable {
    let user: ListUser
    let message: String
}

struct RequestCellView: View {
    let request: Request
    
    var body: some View {
        VStack {
            
            HStack {
                AsyncImage(
                    url: request.user.bitmojiURL,
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 120, maxHeight: 120)
                    },
                    placeholder: {
                        ProgressView()
                    })
               
                VStack(alignment: .leading) {
                    Text(request.user.displayName)
                        .font(.system(size: 28, design: .rounded).bold())
                    
                    Text(request.message)
                        .font(.title3)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Spacer()
                
                
                Group {
                    Text("Add Snap")
                        .bold()
                }
                .font(.title3)
                .padding()
                .frame(width: 150, height: 35)
                .background(.yellow)
                .clipShape(Capsule())
                
                
                Spacer()
                
                Group {
                    Text("No Thanks")
                        .bold()
                }
                .font(.title3)
                .padding()
                .frame(width: 150, height: 35)
                .background(.red)
                .clipShape(Capsule())
                
                Spacer()
            }
        }
        .padding(.vertical)
        
        .background(
            Rectangle()
                .fill(Color.white)
                .cornerRadius(12)
                .shadow(
                    color: Color.gray.opacity(0.8),
                    radius: 8,
                    x: 0,
                    y: 0
                )
        )
        
       // .overlay(
          //      RoundedRectangle(cornerRadius: 16)
              //      .stroke(.secondary, lineWidth: 1)
                
                    //.shadow(color: Color.black.opacity(1.0), radius: 5, x: 5, y: 2)
                    //.shadow(color: .black, radius: 8)
                  //  .shadow(color: Color.yellow.opacity(0.2), radius: 5, x: 0, y: 2)
                   // .background(.white)

          //  )
        
        
        .padding([.top, .trailing, .leading])
        
    }
}

//struct RequestCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestCellView(request: Request(user: User(name: "Alek"), message: "Wanna be friends?"))
//    }
//}
