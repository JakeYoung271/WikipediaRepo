//
//  ScrollTracker.swift
//  TriviaWiki
//
//  Created by Jake Young on 4/4/24.
//

//import Foundation
//import SwiftUI
//
//class scrollTracker: ObservableObject {
//    @Published var yPos: CGFloat = 0
//}
//
//struct endpoint: View {
//    @ObservedObject var output: scrollTracker
//    
//    var body: some View {
//        GeometryReader { geometry in
//            Color.clear
//                .frame(height: 1)
//                .hidden()
//                .onChange(of: geometry.frame(in: .global).minY) { newValue in
//                    output.yPos = newValue
//                }
//        }
//    }
//}
