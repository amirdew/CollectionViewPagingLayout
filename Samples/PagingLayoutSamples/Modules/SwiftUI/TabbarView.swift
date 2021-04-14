//
//  TabbarView.swift
//  PagingLayoutSamples
//
//  Created by Amir Khorsandi on 13/04/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import SwiftUI
import CollectionViewPagingLayout

struct TabbarView: View {

    @State var currentPage: Page.ID?

    var body: some View {
        TransformPageView(Page.allCases, selection: $currentPage) { page, progress in

        }
        .animator(DefaultViewAnimator(0.7, curve: .parametric))
        .scrollToSelectedPage(false)
    }
}

enum Page: String, CaseIterable, Identifiable {
    var id: String {
        rawValue
    }

    case left
    case middle
    case right
}
