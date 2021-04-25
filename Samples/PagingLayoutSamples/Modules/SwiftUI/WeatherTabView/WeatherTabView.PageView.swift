//
//  WeatherTabView.PageView.swift
//  PagingLayoutSamples
//
//  Created by Amir Khorsandi on 15/04/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import SwiftUI

extension WeatherTabView {
    struct PageView: View {
        let page: WeatherPage
        
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                Image("WikipediaLogo")
                    .opacity(0.34)
                Text(page.name)
                    .font(.system(size: 53, weight: .bold, design: .serif))
                ForEach(page.content.items) { item in
                    switch item {
                    case .image(let imageName):
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .border(Color.white, width: 11)
                    case .text(let text):
                        Text(text)
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.bottom, 100)
            .padding(.top, 20)
            .padding(.horizontal, 34)
        }
    }
}

extension WeatherPage.Content.Item: Identifiable {
    var id: String {
        switch self {
        case .image(let data), .text(let data):
            return data.hash.description
        }
    }
}
