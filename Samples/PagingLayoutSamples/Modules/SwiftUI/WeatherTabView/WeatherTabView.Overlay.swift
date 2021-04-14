//
//  WeatherTabView.Overlay.swift
//  PagingLayoutSamples
//
//  Created by Amir Khorsandi on 14/04/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import SwiftUI

extension WeatherTabView {
    struct Overlay: View {
        var body: some View {
            VStack {
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Constant.backgroundColor,
                            Constant.backgroundColor.opacity(0)
                        ]
                    ),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(maxWidth: .infinity, maxHeight: 30)
                .padding(.top, 50)

                Spacer()
            }
        }
    }
}
