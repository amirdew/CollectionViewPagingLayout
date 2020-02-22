//
//  ShapesViewModel.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 15/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

class ShapesViewModel {
    
    // MARK: Properties
    
    var selectedLayoutMode: ShapesLayoutMode = .stackDefault {
        didSet {
            refreshShapeViewModels()
        }
    }
    
    let layoutTypeViewModels: [LayoutTypeCellViewModel] = [
        .init(layout: .scaleLinear, iconName: "rectangle.stack.fill", title: "Scale", subtitle: "Linear"),
        .init(layout: .scaleEaseIn, iconName: "rectangle.stack.fill", title: "Scale", subtitle: "EaseIn"),
        .init(layout: .scaleEaseOut, iconName: "rectangle.stack.fill", title: "Scale", subtitle: "EaseOut"),
        
        .init(layout: .stackDefault, iconName: "rectangle.stack.fill", title: "Stack", subtitle: "Default"),
    ]
    
    var shapeViewModels: [ShapeCardViewModel] = []
    
    private let shapes: [Shape] = [
        .init(name: "Hexagon", iconName: "hexagon.fill"),
        .init(name: "Rectangle", iconName: "rectangle.fill"),
        .init(name: "Shield", iconName: "shield.fill"),
        .init(name: "App", iconName: "app.fill"),
        .init(name: "Triangle", iconName: "triangle.fill"),
        .init(name: "Circle", iconName: "circle.fill"),
        .init(name: "Square", iconName: "square.fill"),
        .init(name: "Capsule", iconName: "capsule.fill")
    ]
    
    
    // MARK: Lifecycle
    
    init() {
        refreshShapeViewModels()
    }
    
    
    // MARK: Private properties
    
    private func refreshShapeViewModels() {
        let colors: [UIColor]
        switch selectedLayoutMode {
        case .scaleLinear, .scaleEaseIn, .scaleEaseOut:
            colors = [#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4, alpha: 1), #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)]
        case .stackDefault:
            colors = [#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4, alpha: 1), #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)]
        }
        shapeViewModels = shapes.map {
            ShapeCardViewModel(iconName: $0.iconName, title: $0.name, colors: colors)
        }
    }
    
}
