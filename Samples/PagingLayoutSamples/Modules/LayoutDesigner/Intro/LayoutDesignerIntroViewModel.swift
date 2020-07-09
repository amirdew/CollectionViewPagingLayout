//
//  LayoutDesignerIntroViewModel.swift
//  PagingLayoutSamples
//
//  Created by Amir on 09/07/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Foundation

struct LayoutDesignerIntroViewModel {
    
    // MARK: Properties
    
    let introPages: [LayoutDesignerIntroInfo]
}


extension Array where Element == LayoutDesignerIntroInfo {
    static var all: [LayoutDesignerIntroInfo] = [
        .init(title: "Welcome to Layout Designer",
              headerImageName: "logoForIntro" ,
              imageName: nil,
              description: """
                          The easiest way to make a beautiful paging layout for your UICollectionView.
                          You can use it for your iOS, iPadOS, and macOS Catalyst app.
                          """,
              leftButtonTitle: "Skip",
              rightButtonTitle: "Show me how!"),
        .init(title: "Select the layout group",
              headerImageName: nil,
              imageName: "intro01",
              description: """
                        There are three groups of layouts available.
                        You can switch between them quickly and see the live preview on the middle panel.
                        """,
              leftButtonTitle: "Previous",
              rightButtonTitle: "Next"),
        .init(title: "Select the layout type ",
              headerImageName: nil,
              imageName: "intro02",
              description: """
                         There are many layouts available for each group.
                         You can switch between them by clicking on the circles.
                         If you use a Trackpad you can also switch between them by scrolling to right and left.
                         """,
              leftButtonTitle: "Previous",
              rightButtonTitle: "Next"),
        .init(title: "Switch between shapes and adjust options ",
              headerImageName: nil,
              imageName: "intro03",
              description: """
                           Now you can see the result on the sample cards (orange cards)
                           You can switch between them to see the animation by clicking on the arrows or on the card itself.
                           If you use a Trackpad you can also switch between them by scrolling to right and left.
                           Now adjust the options if needed and see changes in real-time.
                           """,
              leftButtonTitle: "Previous",
              rightButtonTitle: "Next"),
        .init(title: "That’s it! your code is ready to use!",
              headerImageName: nil,
              imageName: "intro04",
              description: """
                     You can copy the generated code and use it in your project
                     If you need to see how to use the code try “Save as Project” and open it with Xcode
                     """,
              leftButtonTitle: "Previous",
              rightButtonTitle: "Design Layout!")
    ]
    
    
    static var allExceptWelcome: [LayoutDesignerIntroInfo] {
        var list = Array(all.dropFirst())
        list[0].leftButtonTitle = "Close"
        return list
    }
}
