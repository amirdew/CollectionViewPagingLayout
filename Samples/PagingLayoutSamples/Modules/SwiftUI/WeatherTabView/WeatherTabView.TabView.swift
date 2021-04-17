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
                    buttons
                }
                .cornerRadius(21)
                .frame(height: 72)
                .padding(.horizontal, 23)
                .padding(.bottom, 20)
                .animation(.easeInOut)
            }
        }

        private var buttons: some View {
            HStack(spacing: 0) {
                Spacer(minLength: 0)
                    .frame(maxWidth: isSelected(WeatherPage.allCases.first) ? 12 : .infinity)

                ForEach(WeatherPage.allCases) { page in
                    Button {
                        selection = page.id
                    } label: {
                        HStack {
                            Spacer(minLength: isSelected(page) ? 12 : 0)
                            Image(systemName: page.imageName)
                                .font(.system(size: 25))
                            if isSelected(page) {
                                Text(page.name)
                                    .font(.system(size: 18, weight: .light))
                                    .lineLimit(1)
                                    .fixedSize()
                            }
                            Spacer(minLength: isSelected(page) ? 12 : 0)
                        }
                        .padding(.vertical, 9)
                        .background(
                            isSelected(page) ? Color.black.opacity(0.15) : Color.clear
                        )
                        .cornerRadius(17)
                    }
                    Spacer(minLength: 0)
                        .frame(maxWidth: page == WeatherPage.allCases.last && isSelected(WeatherPage.allCases.last) ? 12 : .infinity)
                }
            }
            .foregroundColor(.white)
        }

        private func isSelected(_ page: WeatherPage?) -> Bool {
            page?.id == selection ?? WeatherPage.allCases.first?.id
        }

    }
}

struct WeatherTabView_TabView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherTabView.TabView(selection: .constant(WeatherPage.sun.id))
                .previewLayout(.fixed(width: 450, height: 300))

            WeatherTabView.TabView(selection: .constant(WeatherPage.tornado.id))
                .previewLayout(.fixed(width: 375, height: 300))

            WeatherTabView.TabView(selection: .constant(WeatherPage.lightning.id))
                .previewLayout(.fixed(width: 320, height: 300))
        }
    }
}
