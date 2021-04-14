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

    @State var currentPage: WeatherPage.ID?

    var body: some View {
        ZStack {
            TabView()
            TransformPageView(WeatherPage.allCases, selection: $currentPage) { page, progress in

            }
            .animator(DefaultViewAnimator(0.7, curve: .parametric))
        }
    }
}

enum WeatherPage: String, CaseIterable, Identifiable {
    case sun
    case bolt
    case moon
    case tornado
    case snow

    var id: String {
        rawValue
    }

    var imageName: String {
        switch self {
        case .sun:
            return "sun.max.fill"
        case .bolt:
            return "cloud.bolt.rain.fill"
        case .moon:
            return "moon.stars.fill"
        case .tornado:
            return "tornado"
        case .snow:
            return "snow"
        }
    }

}
