//
//  ShapesViewModel.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 15/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit
import CollectionViewPagingLayout

class ShapesViewModel {
    
    // MARK: Static Properties
    
    private(set) static var scaleOptions: ScaleTransformViewOptions = .init()
    private(set) static var stackOptions: StackTransformViewOptions = .init()
    private(set) static var snapshotOptions: SnapshotTransformViewOptions = .init()
    
    
    // MARK: Properties
    
    var selectedLayout: LayoutTypeCellViewModel {
        didSet {
            if let options = selectedLayout.layout.scaleOptions {
                ShapesViewModel.scaleOptions = options
            } else if let options = selectedLayout.layout.stackOptions {
                ShapesViewModel.stackOptions = options
            } else if let options = selectedLayout.layout.snapshotOptions {
                ShapesViewModel.snapshotOptions = options
            }
        }
    }
    let layoutTypeViewModels: [LayoutTypeCellViewModel]
    let showBackButton: Bool
    
    
    // MARK: Lifecycle
    
    init(layouts: [ShapeLayout], showBackButton: Bool = true) {
        self.showBackButton = showBackButton
        self.layoutTypeViewModels = layouts.compactMap { layout in  ShapesViewModel.allLayoutViewModes.first { $0.layout == layout } }
        selectedLayout = layoutTypeViewModels.first!
    }
    
    
    // MARK: Public functions
    
    func setCustomOptions<T>(_ options: T) {
        if let options = options as? ScaleTransformViewOptions {
            ShapesViewModel.scaleOptions = options
        } else if let options = options as? StackTransformViewOptions {
            ShapesViewModel.stackOptions = options
        } else if let options = options as? SnapshotTransformViewOptions {
            ShapesViewModel.snapshotOptions = options
        }
    }
}


extension ShapesViewModel {
    
    static let allLayoutViewModes: [LayoutTypeCellViewModel] = [
        .init(layout: .scaleInvertedCylinder,
              iconName: "scale_invertedcylinder",
              title: "Scale",
              subtitle: "Inverted Cylinder",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4, alpha: 1), #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)])),
        .init(layout: .scaleCylinder,
              iconName: "scale_cylinder",
              title: "Scale",
              subtitle: "Cylinder",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4, alpha: 1), #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)])),
        .init(layout: .scaleCoverFlow,
              iconName: "scale_coverflow",
              title: "Scale",
              subtitle: "Cover Flow",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4, alpha: 1), #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)])),
        .init(layout: .scaleLinear,
              iconName: "scale_normal",
              title: "Scale",
              subtitle: "Linear",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4, alpha: 1), #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)])),
        .init(layout: .scaleEaseIn,
              iconName: "scale_normal",
              title: "Scale",
              subtitle: "EaseIn",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4, alpha: 1), #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)])),
        .init(layout: .scaleEaseOut,
              iconName: "scale_normal",
              title: "Scale",
              subtitle: "EaseOut",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4, alpha: 1), #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)])),
        .init(layout: .scaleRotary,
              iconName: "scale_rotary",
              title: "Scale",
              subtitle: "Rotary",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4, alpha: 1), #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)])),
        .init(layout: .scaleBlur,
              iconName: "scale_blur",
              title: "Scale",
              subtitle: "Blurry",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4, alpha: 1), #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)])),
        
        .init(layout: .stackTransparent,
              iconName: "stack_transparent",
              title: "Stack",
              subtitle: "Transparent",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.3058823529, green: 1, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.1137254902, green: 0.4156862745, blue: 0.6666666667, alpha: 1)])),
        .init(layout: .stackPerspective,
              iconName: "stack_prespective",
              title: "Stack",
              subtitle: "Perspective",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.3058823529, green: 1, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.1137254902, green: 0.4156862745, blue: 0.6666666667, alpha: 1)])),
        .init(layout: .stackRotary,
              iconName: "stack_rotary",
              title: "Stack",
              subtitle: "Rotary",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.3058823529, green: 1, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.1137254902, green: 0.4156862745, blue: 0.6666666667, alpha: 1)])),
        .init(layout: .stackBlur,
              iconName: "stack_blur",
              title: "Stack",
              subtitle: "Blur",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.3058823529, green: 1, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.1137254902, green: 0.4156862745, blue: 0.6666666667, alpha: 1)])),
        .init(layout: .stackVortex,
              iconName: "stack_vortex",
              title: "Stack",
              subtitle: "Vortex",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.3058823529, green: 1, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.1137254902, green: 0.4156862745, blue: 0.6666666667, alpha: 1)])),
        .init(layout: .stackReverse,
              iconName: "stack_reverse",
              title: "Stack",
              subtitle: "Reverse",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.3058823529, green: 1, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.1137254902, green: 0.4156862745, blue: 0.6666666667, alpha: 1)])),
        
        .init(layout: .snapshotGrid,
              iconName: "snapshot_grid",
              title: "Snapshot",
              subtitle: "Grid",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.9176470588, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.3137254902, green: 0.8, blue: 1, alpha: 1)])),
        .init(layout: .snapshotSpace,
              iconName: "snapshot_space",
              title: "Snapshot",
              subtitle: "Space",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.9176470588, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.3137254902, green: 0.8, blue: 1, alpha: 1)])),
        .init(layout: .snapshotChess,
              iconName: "snapshot_chess",
              title: "Snapshot",
              subtitle: "Chess",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.9176470588, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.3137254902, green: 0.8, blue: 1, alpha: 1)])),
        .init(layout: .snapshotTiles,
              iconName: "snapshot_tiles",
              title: "Snapshot",
              subtitle: "Tiles",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.9176470588, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.3137254902, green: 0.8, blue: 1, alpha: 1)])),
        .init(layout: .snapshotLines,
              iconName: "snapshot_lines",
              title: "Snapshot",
              subtitle: "Lines",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.9176470588, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.3137254902, green: 0.8, blue: 1, alpha: 1)])),
        .init(layout: .snapshotBars,
              iconName: "snapshot_bars",
              title: "Snapshot",
              subtitle: "Bars",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.9176470588, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.3137254902, green: 0.8, blue: 1, alpha: 1)])),
        .init(layout: .snapshotPuzzle,
              iconName: "snapshot_puzzle",
              title: "Snapshot",
              subtitle: "Puzzle",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.9176470588, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.3137254902, green: 0.8, blue: 1, alpha: 1)])),
        .init(layout: .snapshotFade,
              iconName: "snapshot_fade",
              title: "Snapshot",
              subtitle: "Fade",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.9176470588, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.3137254902, green: 0.8, blue: 1, alpha: 1)]))
    ]
    
    private static func generateCardViewModels(colors: [UIColor]) -> [ShapeCardViewModel] {
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
        return shapes.map {
            ShapeCardViewModel(iconName: $0.iconName, title: $0.name, colors: colors)
        }
    }
}
