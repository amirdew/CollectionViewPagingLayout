//
//  LayoutDesignerViewModel.swift
//  PagingLayoutSamples
//
//  Created by Amir on 27/06/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Foundation
import CollectionViewPagingLayout

class LayoutDesignerViewModel {
    
    // MARK: Properties
    
    var onCodePreviewViewModelChange: ((LayoutDesignerCodePreviewViewModel) -> Void)?
    var onOptionsChange: (() -> Void)?
    var selectedLayout: ShapeLayout? {
        didSet {
            refreshOptionViewModels()
        }
    }
    var layouts: [ShapeLayout] = .stack
    var shapesViewModel: ShapesViewModel {
        ShapesViewModel(layouts: layouts, showBackButton: false)
    }
    private(set) var optionViewModels: [LayoutDesignerOptionCellViewModel] = []
    private let codeGenerator = OptionsCodeGenerator()
    
    
    // MARK: Public functions
    
    private func updateCodePreview<T>(options: T) {
        onCodePreviewViewModelChange?(.init(code: codeGenerator.generateCode(options: options)))
    }
    private func update<T>(options: inout T, closure: (inout T) -> Void) {
        closure(&options)
        updateCodePreview(options: options)
        shapesViewModel.setCustomOptions(options)
        onOptionsChange?()
    }
    
    private func refreshOptionViewModels() {
        guard let selectedLayout = selectedLayout else {
            optionViewModels = []
            return
        }
        
        if var options = selectedLayout.scaleOptions {
            updateCodePreview(options: options)
            let update: ((inout ScaleTransformViewOptions) -> Void) -> Void = {  [weak self] in
                self?.update(options: &options, closure: $0)
            }
            
            optionViewModels = [
                .init(title: "Min scale", kind: .singleSlider(current: options.minScale) { n in
                    update { $0.minScale = n }
                    }),
                .init(title: "Max scale", kind: .singleSlider(current: options.maxScale) { n in
                    update { $0.maxScale = n }
                    }),
                .init(title: "Scale ratio", kind: .singleSlider(current: options.scaleRatio) { n in
                    update { $0.scaleRatio = n }
                    }),
                .init(title: "Translation ratio", kind: .doubleSlider(current: options.translationRatio.pair) { n in
                    update { $0.translationRatio = .by(pair: n) }
                    }),
                .init(title: "Min translation ratio", kind: .doubleSlider(current: options.minTranslationRatio?.pair) { n in
                    update { $0.minTranslationRatio = .by(pair: n) }
                    }),
                .init(title: "Max translation ratio", kind: .doubleSlider(current: options.maxTranslationRatio?.pair) { n in
                    update { $0.maxTranslationRatio = .by(pair: n) }
                    }),
                .init(title: "Keep vertical spacing equal", kind: .toggleSwitch(current: options.keepVerticalSpacingEqual) { n in
                    update { $0.keepVerticalSpacingEqual = n }
                    }),
                .init(title: "Keep horizontal spacing equal", kind: .toggleSwitch(current: options.keepHorizontalSpacingEqual) { n in
                    update { $0.keepHorizontalSpacingEqual = n }
                    }),
                .init(title: "Scale curve", kind: .segmented(options: TransformCurve.all.map(\.name), current: options.scaleCurve.name) { n in
                    update { $0.scaleCurve = .by(name: n)! }
                    })
            ]
        } else if var options = selectedLayout.stackOptions {
            updateCodePreview(options: options)
            let update: ((inout StackTransformViewOptions) -> Void) -> Void = {  [weak self] in
                self?.update(options: &options, closure: $0)
            }
            
        } else if var options = selectedLayout.snapshotOptions {
            updateCodePreview(options: options)
            let update: ((inout SnapshotTransformViewOptions) -> Void) -> Void = {  [weak self] in
                self?.update(options: &options, closure: $0)
            }
        }
    }
}
