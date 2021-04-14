//
//  WeatherTabView.swift
//  PagingLayoutSamples
//
//  Created by Amir Khorsandi on 13/04/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

// swiftlint:disable line_length

import SwiftUI
import CollectionViewPagingLayout

struct WeatherTabView: View {

    @State var currentPage: WeatherPage.ID?


    var body: some View {
        ZStack {
            Constant.backgroundColor.ignoresSafeArea()

            SnapshotPageView(WeatherPage.allCases, selection: $currentPage) { page in
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Image("WikipediaLogo")
                            .opacity(0.34)
                        Text(page.name)
                            .font(.system(size: 62, weight: .bold, design: .serif))
                        Text(
                            """
                            A tornado is a violently rotating column of air that is in contact with both the surface of the Earth and a cumulonimbus cloud or, in rare cases, the base of a cumulus cloud.

                            The windstorm is often referred to as a twister, whirlwind or cyclone,[1] although the word cyclone is used in meteorology to name a weather system with a low-pressure area in the center around which, from an observer looking down toward the surface of the earth, winds blow counterclockwise in the Northern Hemisphere and clockwise in the Southern.
                            """
                        )
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                        [WeatherPage.sun, .tornado, .snow].contains(page) ? Image("cherryImage") : Image("appleImage")
                        Text(
                            """
                            A tornado is a violently rotating column of air that is in contact with both the surface of the Earth and a cumulonimbus cloud or, in rare cases, the base of a cumulus cloud.

                            The windstorm is often referred to as a twister, whirlwind or cyclone,[1] although the word cyclone is used in meteorology to name a weather system with a low-pressure area in the center around which, from an observer looking down toward the surface of the earth, winds blow counterclockwise in the Northern Hemisphere and clockwise in the Southern.
                            """
                        )
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                        Image("appleImage")
                    }
                    .padding(.horizontal, 34)
                    .padding(.top, 20)
                }
            }
            //.numberOfVisibleItems(3)
            .animator(DefaultViewAnimator(0.7, curve: .parametric))
            .options(.layout(.lines))
            .padding(.top, 50)
            .padding(.bottom, 12)

            TabView(selection: $currentPage)
        }
        .overlay(Overlay())
    }
}
