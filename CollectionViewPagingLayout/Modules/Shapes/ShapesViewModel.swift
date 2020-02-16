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
    
    let layoutTypeViewModels: [LayoutTypeCellViewModel] = [
        .init(iconName: "rectangle.stack.fill", title: "Stack", subtitle: "Center"),
        .init(iconName: "rectangle.stack.fill", title: "Stack", subtitle: "Left"),
        .init(iconName: "rectangle.stack.fill", title: "Stack", subtitle: "Right"),
        .init(iconName: "rectangle.stack.fill", title: "Stack", subtitle: "Center"),
        .init(iconName: "rectangle.stack.fill", title: "Stack", subtitle: "Left"),
        .init(iconName: "rectangle.stack.fill", title: "Stack", subtitle: "Right"),
        .init(iconName: "rectangle.stack.fill", title: "Stack", subtitle: "Center"),
        .init(iconName: "rectangle.stack.fill", title: "Stack", subtitle: "Left"),
        .init(iconName: "rectangle.stack.fill", title: "Stack", subtitle: "Right"),
    ]
    
    
    let shapeViewModels: [ShapeCellViewModel] = [
        .init(iconName: "hexagon.fill",
              title: "Hexagon",
              colors: [UIColor(red: 253/255, green: 110/255, blue: 106/255, alpha: 1), UIColor(red: 255/255, green: 198/255, blue: 0/255, alpha: 1)]),
        .init(iconName: "shield.fill",
              title: "Shield",
              colors: [UIColor(red: 253/255, green: 110/255, blue: 106/255, alpha: 1), UIColor(red: 255/255, green: 198/255, blue: 0/255, alpha: 1)]),
        .init(iconName: "app.fill",
              title: "App",
              colors: [UIColor(red: 253/255, green: 110/255, blue: 106/255, alpha: 1), UIColor(red: 255/255, green: 198/255, blue: 0/255, alpha: 1)]),
        .init(iconName: "triangle.fill",
              title: "Triangle",
              colors: [UIColor(red: 253/255, green: 110/255, blue: 106/255, alpha: 1), UIColor(red: 255/255, green: 198/255, blue: 0/255, alpha: 1)])
    ]
}
