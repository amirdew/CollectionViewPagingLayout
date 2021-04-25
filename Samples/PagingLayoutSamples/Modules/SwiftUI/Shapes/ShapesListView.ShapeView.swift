//
//  ShapesListView.ShapeView.swift
//  PagingLayoutSamples
//
//  Created by Amir Khorsandi on 17/04/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import SwiftUI

extension ShapesListView {
    struct ShapeView: View {
        let shape: Shape
        let color: LinearGradient

        var body: some View {
            ZStack {
                color
                    .border(Color.white, width: 6)
                VStack {
                    Image(systemName: shape.iconName)
                        .font(.system(size: 42))
                        .padding(.bottom, 10)
                    Text(shape.name)
                        .font(.title2)
                    Image("textPlaceholder")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 90)
                        .padding(.horizontal, 20)
                }
            }
            .foregroundColor(.white)
        }
    }
}

struct ShapesListView_ShapeView_Previews: PreviewProvider {
    static var previews: some View {
        ShapesListView.ShapeView(
            shape: .init(name: "Hexagon", iconName: "hexagon.fill"),
            color: LinearGradient(
                gradient: .init(colors: [.red, .black]),
                startPoint: .topLeading,
                endPoint: .bottomLeading
            )
        )
        .previewLayout(.fixed(width: 190, height: 300))
    }
}
