//
//  WeatherPage.swift
//  PagingLayoutSamples
//
//  Created by Amir Khorsandi on 14/04/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import Foundation

enum WeatherPage: String, CaseIterable, Identifiable {
    case sun
    case bolt
    case tornado
    case moon
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

    var name: String {
        rawValue.prefix(1).capitalized + rawValue.dropFirst()
    }

}
