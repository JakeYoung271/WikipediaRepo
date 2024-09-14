//
//  TutorialView.swift
//  TriviaWiki
//
//  Created by Jake Young on 9/13/24.
//

import SwiftUI

struct TutorialView: View {
    let tutorialImages = ["Slide1", "Slide2", "Slide3", "Slide4", "Slide5", "Slide6",]
    var body: some View {
        ScrollView {
            VStack {
                ForEach(tutorialImages, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .padding()
                    Divider()
                        .frame(height:5)
                }
            }
        }
    }
}

#Preview {
    TutorialView()
}
