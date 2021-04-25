//
//  ShapeCollectionViewCells.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 15/02/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit
import CollectionViewPagingLayout

class ScaleShapeCollectionViewCell: BaseShapeCollectionViewCell, ScaleTransformView {
    var scaleOptions: ScaleTransformViewOptions {
        ShapesViewModel.scaleOptions
    }
}


class StackShapeCollectionViewCell: BaseShapeCollectionViewCell, StackTransformView {
    var stackOptions: StackTransformViewOptions {
        ShapesViewModel.stackOptions
    }
}


class SnapshotShapeCollectionViewCell: BaseShapeCollectionViewCell, SnapshotTransformView {
    var snapshotOptions: SnapshotTransformViewOptions {
        ShapesViewModel.snapshotOptions
    }
}
