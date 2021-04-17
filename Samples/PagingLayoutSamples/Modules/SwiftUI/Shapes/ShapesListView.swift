//
//  ShapesListView.swift
//  PagingLayoutSamples
//
//  Created by Amir Khorsandi on 17/04/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import SwiftUI
import CollectionViewPagingLayout

struct ShapesListView: View {

    let layoutGroup: LayoutGroup

    let shapes: [Shape] = [
        .init(name: "Hexagon", iconName: "hexagon.fill"),
        .init(name: "Rectangle", iconName: "rectangle.fill"),
        .init(name: "Shield", iconName: "shield.fill"),
        .init(name: "App", iconName: "app.fill"),
        .init(name: "Triangle", iconName: "triangle.fill"),
        .init(name: "Circle", iconName: "circle.fill"),
        .init(name: "Square", iconName: "square.fill"),
        .init(name: "Capsule", iconName: "capsule.fill")
    ]

    var scaleGradient: LinearGradient {
        LinearGradient(gradient: .init(colors: [Color("pastelRed"), Color("supernova")]),
                       startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    var stackGradient: LinearGradient {
        LinearGradient(gradient: .init(colors: [Color("babyBlue"), Color("matisse")]),
                       startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    var snapshotGradient: LinearGradient {
        LinearGradient(gradient: .init(colors: [Color("chartreuseYellow"), Color("mayaBlue")]),
                       startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    var body: some View {
        VStack {
            Text("S\(String(layoutGroup.rawValue.dropFirst()))PageView")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 19)

            ScrollView {
                switch layoutGroup {
                case .stack:
                    stackLayouts()
                case .scale:
                    scaleLayouts()
                case .snapshot:
                    snapshotLayouts()
                }
            }
            .frame(maxWidth: .infinity)
        }
    }

    func stackLayouts() -> some View {
        ForEach(StackTransformViewOptions.Layout.allCases) { layout in
            VStack(alignment: .leading) {
                layoutTitle(layout.rawValue)
                StackPageView(shapes) { shape in
                    ShapeView(shape: shape, color: stackGradient)
                }
                .options(.layout(layout))
                .pagePadding(vertical: .fractionalHeight(0.1),
                             horizontal: .fractionalWidth(0.3))
                .frame(height: 300)
                .padding(10)
                .background(Color("Background"))
                .cornerRadius(26)
            }
            .padding(19)
        }
    }

    func scaleLayouts() -> some View {
        ForEach(ScaleTransformViewOptions.Layout.allCases) { layout in
            VStack(alignment: .leading) {
                layoutTitle(layout.rawValue)
                ScalePageView(shapes) { shape in
                    ShapeView(shape: shape, color: scaleGradient)
                }
                .options(.layout(layout))
                .pagePadding(vertical: .fractionalHeight(0.1),
                             horizontal: .fractionalWidth(0.3))
                .frame(height: 300)
                .padding(10)
                .background(Color("Background"))
                .cornerRadius(26)
            }
            .padding(19)
        }
    }

    func snapshotLayouts() -> some View {
        ForEach(SnapshotTransformViewOptions.Layout.allCases) { layout in
            VStack(alignment: .leading) {
                layoutTitle(layout.rawValue)
                SnapshotPageView(shapes) { shape in
                    ShapeView(shape: shape, color: snapshotGradient)
                }
                .options(.layout(layout))
                .pagePadding(vertical: .fractionalHeight(0.1),
                             horizontal: .fractionalWidth(0.3))
                .frame(height: 300)
                .padding(10)
                .background(Color("Background"))
                .cornerRadius(26)
            }
            .padding(19)
        }
    }

    func layoutTitle(_ title: String) -> some View {
        Text(".\(title)")
            .fontWeight(.semibold)
            .foregroundColor(.gray)
            .padding(.bottom, 8)
    }
}

extension StackTransformViewOptions.Layout: Identifiable {
    public var id: String {
        rawValue
    }
}
extension ScaleTransformViewOptions.Layout: Identifiable {
    public var id: String {
        rawValue
    }
}
extension SnapshotTransformViewOptions.Layout: Identifiable {
    public var id: String {
        rawValue
    }
}


extension ShapesListView {
    enum LayoutGroup: String {
        case stack, scale, snapshot
    }
}
