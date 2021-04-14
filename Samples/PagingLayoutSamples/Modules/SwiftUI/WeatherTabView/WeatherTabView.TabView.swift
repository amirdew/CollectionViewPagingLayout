//
//  WeatherTabView.TabView.swift
//  PagingLayoutSamples
//
//  Created by Amir Khorsandi on 14/04/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import SwiftUI

extension WeatherTabView {
    struct TabView: View {
        @Binding var selection: WeatherPage.ID?

        var body: some View {
            VStack {
                Spacer()
                ZStack(alignment: .center) {
                    VisualEffectView(style: .systemUltraThinMaterialDark)
                    HStack {
                        Spacer(minLength: 0)
                        ForEach(WeatherPage.allCases) { page in
                            HStack {
                                Spacer(minLength: 0)
                                    .frame(maxWidth: 12)
                                Image(systemName: page.imageName)
                                    .font(.system(size: 25))
                                if isSelected(page) {
                                    Text(page.name)
                                        .font(.system(size: 18, weight: .light))
                                        .lineLimit(1)
                                        .layoutPriority(2)
                                }
                                Spacer(minLength: 0)
                                    .frame(maxWidth: 12)
                            }
                            .padding(.vertical, 9)
                            .background(isSelected(page) ? Color.black.opacity(0.2) : Color.clear)
                            .cornerRadius(17)
                            .onTapGesture {
                                selection = page.id
                            }
                            Spacer(minLength: 0)
                        }
                    }
                    .padding(.horizontal, 4)
                    .foregroundColor(.white)
                }
                .cornerRadius(21)
                .frame(height: 72)
                .padding(.horizontal, 23)
                .padding(.bottom, 20)
                .animation(.easeInOut)
            }
        }

        private func isSelected(_ page: WeatherPage) -> Bool {
            page.id == selection ?? WeatherPage.allCases.first?.id
        }

    }
}
