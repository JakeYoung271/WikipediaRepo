//
//  AreYouSureView.swift
//  TriviaWiki
//
//  Created by Jake Young on 5/29/24.
//

import SwiftUI

struct AreYouSureView: View {
    var yes: ()-> Void
    var no: ()-> Void
    var body: some View {
        VStack{
            Text("Are you sure you want to see the answer?")
                .font(.title)
                .multilineTextAlignment(.center)
            HStack{
                
                Button(action:yes){
                    Text("Yes, show me")
                        .padding()
                        .foregroundStyle(.black)
                        .background(
                    Rectangle()
                        .fill(.green)
                        .cornerRadius(10)
                    )
                }
                Button(action:no){
                    Text("No, not yet")
                        .padding()
                        .foregroundStyle(.black)
                        .background(
                    Rectangle()
                        .fill(.red)
                        .cornerRadius(10)
                    )
                }
            }
        }
        .padding(20)
        .background(
            Rectangle()
                .fill(.white))
        .cornerRadius(20)
        .padding(1)
        .background(Rectangle().fill(.black).cornerRadius(20))
        .shadow(radius: 10)
        .overlay(
            VStack {
                HStack {
                    Spacer()
                    Button(action: no) {
                        Image(systemName: "x.circle")
                            .font(.title)
                            .foregroundColor(.black)
                            .offset(x:8, y:-8)
                            .padding(-2)
                            .background(
                                Circle()
                                    .fill(.white)
                                    .offset(x:8, y:-8)
                                    .shadow(radius:10))
                    }
                }
                Spacer()
            }
        )
    }
}

#Preview {
    AreYouSureView(yes: {}, no: {})
}
