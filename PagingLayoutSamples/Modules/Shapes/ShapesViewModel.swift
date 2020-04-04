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
    
    var selectedLayout: LayoutTypeCellViewModel
    let layoutTypeViewModels: [LayoutTypeCellViewModel]
    
    
    // MARK: Lifecycle
    
    init(layouts: [ShapeLayout]) {
        self.layoutTypeViewModels = layouts.compactMap { layout in  ShapesViewModel.allLayoutViewModes.first { $0.layout == layout } }
        selectedLayout = layoutTypeViewModels.first!
    }
    
}


extension ShapesViewModel {
    
    static let allLayoutViewModes: [LayoutTypeCellViewModel] = [
        .init(layout: .scaleInvertedCylinder,
              iconName: "rectangle.stack.fill",
              title: "Scale",
              subtitle: "Inverted Cylinder",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4, alpha: 1), #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)]),
              cellClass: ScaleInvertedCylinderShapeCollectionViewCell.self),
        .init(layout: .scaleCylinder,
              iconName: "rectangle.stack.fill",
              title: "Scale",
              subtitle: "Cylinder",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4, alpha: 1), #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)]),
              cellClass: ScaleCylinderShapeCollectionViewCell.self),
        .init(layout: .scaleCoverFlow,
              iconName: "rectangle.stack.fill",
              title: "Scale",
              subtitle: "Cover Flow",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4, alpha: 1), #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)]),
              cellClass: ScaleCoverFlowShapeCollectionViewCell.self),
        .init(layout: .scaleLinear,
              iconName: "rectangle.stack.fill",
              title: "Scale",
              subtitle: "Linear",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4, alpha: 1), #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)]),
              cellClass: ScaleLinearShapeCollectionViewCell.self),
        .init(layout: .scaleEaseIn,
              iconName: "rectangle.stack.fill",
              title: "Scale",
              subtitle: "EaseIn",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4, alpha: 1), #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)]),
              cellClass: ScaleEaseInShapeCollectionViewCell.self),
        .init(layout: .scaleEaseOut,
              iconName: "rectangle.stack.fill",
              title: "Scale",
              subtitle: "EaseOut",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4, alpha: 1), #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)]),
              cellClass: ScaleEaseOutShapeCollectionViewCell.self),
        .init(layout: .scaleRotary,
              iconName: "rectangle.stack.fill",
              title: "Scale",
              subtitle: "Rotary",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4, alpha: 1), #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)]),
              cellClass: ScaleRotaryShapeCollectionViewCell.self),
        .init(layout: .scaleBlur,
              iconName: "rectangle.stack.fill",
              title: "Scale",
              subtitle: "Blurry",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 1, green: 0.4274509804, blue: 0.4, alpha: 1), #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)]),
              cellClass: ScaleBlurShapeCollectionViewCell.self),
        
        .init(layout: .stackTransparent,
              iconName: "rectangle.stack.fill",
              title: "Stack",
              subtitle: "Transparent",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.3058823529, green: 1, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.1137254902, green: 0.4156862745, blue: 0.6666666667, alpha: 1)]),
              cellClass: TransparentStackShapeCollectionViewCell.self),
        .init(layout: .stackPerspective,
              iconName: "rectangle.stack.fill",
              title: "Stack",
              subtitle: "Perspective",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.3058823529, green: 1, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.1137254902, green: 0.4156862745, blue: 0.6666666667, alpha: 1)]),
              cellClass: PerspectiveStackShapeCollectionViewCell.self),
        .init(layout: .stackRotary,
              iconName: "rectangle.stack.fill",
              title: "Stack",
              subtitle: "Rotary",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.3058823529, green: 1, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.1137254902, green: 0.4156862745, blue: 0.6666666667, alpha: 1)]),
              cellClass: RotaryStackShapeCollectionViewCell.self),
        .init(layout: .stackBlur,
              iconName: "rectangle.stack.fill",
              title: "Stack",
              subtitle: "Blur",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.3058823529, green: 1, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.1137254902, green: 0.4156862745, blue: 0.6666666667, alpha: 1)]),
              cellClass: BlurStackShapeCollectionViewCell.self),
        .init(layout: .stackVortex,
              iconName: "rectangle.stack.fill",
              title: "Stack",
              subtitle: "Vortex",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.3058823529, green: 1, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.1137254902, green: 0.4156862745, blue: 0.6666666667, alpha: 1)]),
              cellClass: VortexStackShapeCollectionViewCell.self),
        .init(layout: .stackReverse,
              iconName: "rectangle.stack.fill",
              title: "Stack",
              subtitle: "Reverse",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.3058823529, green: 1, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.1137254902, green: 0.4156862745, blue: 0.6666666667, alpha: 1)]),
              cellClass: ReverseStackShapeCollectionViewCell.self),
        
        .init(layout: .snapshotGrid,
              iconName: "rectangle.stack.fill",
              title: "Snapshot",
              subtitle: "Grid",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.9176470588, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.3137254902, green: 0.8, blue: 1, alpha: 1)]),
              cellClass: GridSnapshotShapeCollectionViewCell.self),
        .init(layout: .snapshotSpace,
              iconName: "rectangle.stack.fill",
              title: "Snapshot",
              subtitle: "Space",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.9176470588, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.3137254902, green: 0.8, blue: 1, alpha: 1)]),
              cellClass: SpaceSnapshotShapeCollectionViewCell.self),
        .init(layout: .snapshotChess,
              iconName: "rectangle.stack.fill",
              title: "Snapshot",
              subtitle: "Chess",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.9176470588, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.3137254902, green: 0.8, blue: 1, alpha: 1)]),
              cellClass: ChessSnapshotShapeCollectionViewCell.self),
        .init(layout: .snapshotTiles,
              iconName: "rectangle.stack.fill",
              title: "Snapshot",
              subtitle: "Tiles",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.9176470588, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.3137254902, green: 0.8, blue: 1, alpha: 1)]),
              cellClass: TilesSnapshotShapeCollectionViewCell.self),
        .init(layout: .snapshotLines,
              iconName: "rectangle.stack.fill",
              title: "Snapshot",
              subtitle: "Lines",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.9176470588, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.3137254902, green: 0.8, blue: 1, alpha: 1)]),
              cellClass: LinesSnapshotShapeCollectionViewCell.self),
        .init(layout: .snapshotBars,
              iconName: "rectangle.stack.fill",
              title: "Snapshot",
              subtitle: "Bars",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.9176470588, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.3137254902, green: 0.8, blue: 1, alpha: 1)]),
              cellClass: BarsSnapshotShapeCollectionViewCell.self),
        .init(layout: .snapshotPuzzle,
              iconName: "rectangle.stack.fill",
              title: "Snapshot",
              subtitle: "Puzzle",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.9176470588, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.3137254902, green: 0.8, blue: 1, alpha: 1)]),
              cellClass: PuzzleSnapshotShapeCollectionViewCell.self),
        .init(layout: .snapshotFade,
              iconName: "rectangle.stack.fill",
              title: "Snapshot",
              subtitle: "Fade",
              cardViewModels: generateCardViewModels(colors: [#colorLiteral(red: 0.9176470588, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.3137254902, green: 0.8, blue: 1, alpha: 1)]),
              cellClass: FadeSnapshotShapeCollectionViewCell.self),
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
