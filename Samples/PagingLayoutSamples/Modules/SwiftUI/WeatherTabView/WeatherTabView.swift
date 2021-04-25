//
//  WeatherTabView.swift
//  PagingLayoutSamples
//
//  Created by Amir Khorsandi on 13/04/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import SwiftUI
import CollectionViewPagingLayout

struct WeatherTabView: View {

    @State private var currentPage: WeatherPage.ID?

    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()

            SnapshotPageView(WeatherPage.allCases, selection: $currentPage) { page in
                ScrollView(showsIndicators: false) {
                    PageView(page: page)
                }
            }
            .animator(DefaultViewAnimator(0.7, curve: .parametric))
            .options(options)
            .padding(.top, 50)
            .overlay(Overlay())

            TabView(selection: $currentPage)
        }
    }

    private var options = SnapshotTransformViewOptions(
        pieceSizeRatio: .init(width: 0.2, height: 1),
        piecesAlphaRatio: .static(0),
        piecesTranslationRatio: .columnOddEven(CGPoint(x: 0, y: 0.1), CGPoint(x: 0, y: -0.1)),
        piecesScaleRatio: .columnOddEven(.init(width: 1, height: 0), .init(width: 0, height: 0)),
        containerScaleRatio: 0,
        containerTranslationRatio: .init(x: 1, y: 0)
    )
}
