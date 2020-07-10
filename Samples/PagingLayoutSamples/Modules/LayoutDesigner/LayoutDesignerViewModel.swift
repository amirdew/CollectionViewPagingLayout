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
    var layouts: [ShapeLayout] = .scale
    var shapesViewModel: ShapesViewModel {
        ShapesViewModel(layouts: layouts, showBackButton: false, showPageControl: true)
    }
    var shouldShowIntro: Bool {
        if let introShown = UserDefaults.standard.value(forKey: "IntroShown") as? Bool, introShown {
            return false
        }
        UserDefaults.standard.setValue(true, forKey: "IntroShown")
        return true
    }
    
    
    private(set) var optionViewModels: [LayoutDesignerOptionSectionViewModel] = []
    private let codeGenerator = OptionsCodeGenerator()
    
    
    // MARK: Public functions
    
    func getIntroViewModel(showWelcome: Bool = true) -> LayoutDesignerIntroViewModel {
        LayoutDesignerIntroViewModel(introPages: showWelcome ? .all : .allExceptWelcome)
    }
    
    
    // MARK: Private functions
    
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
        
        if let options = selectedLayout.scaleOptions {
            optionViewModels = getOptionViewModels(scaleOptions: options)
        } else if let options = selectedLayout.stackOptions {
            optionViewModels = getOptionViewModels(stackOptions: options)
        } else if let options = selectedLayout.snapshotOptions {
            optionViewModels = getOptionViewModels(snapshotOptions: options)
        }
    }
    
    private func getOptionViewModels(scaleOptions: ScaleTransformViewOptions) -> [LayoutDesignerOptionSectionViewModel] {
        var options = scaleOptions
        updateCodePreview(options: options)
        let update: ((inout ScaleTransformViewOptions) -> Void) -> Void = {  [weak self] in
            self?.update(options: &options, closure: $0)
        }
        
        let generalOptions: [LayoutDesignerOptionViewModel] = [
            .init(title: "Min scale", kind: .singleSlider(current: options.minScale, range: 0...2) { n in
                update { $0.minScale = n! }
                }),
            .init(title: "Max scale", kind: .singleSlider(current: options.maxScale, range: 0...2) { n in
                update { $0.maxScale = n! }
                }),
            .init(title: "Scale ratio", kind: .singleSlider(current: options.scaleRatio, range: 0...2) { n in
                update { $0.scaleRatio = n! }
                }),
            .init(title: "Translation ratio", kind: .doubleSlider(current: options.translationRatio.pair, range: -2...2) { n in
                update { $0.translationRatio = .by(pair: n!) }
                }),
            .init(title: "Min translation ratio", kind: .doubleSlider(current: options.minTranslationRatio?.pair, range: -5...5, optional: true) { n in
                update { $0.minTranslationRatio = n.map { .by(pair: $0) } }
                }),
            .init(title: "Max translation ratio", kind: .doubleSlider(current: options.maxTranslationRatio?.pair, range: -5...5, optional: true) { n in
                update { $0.maxTranslationRatio = n.map { .by(pair: $0) } }
                }),
            .init(title: "Keep vertical spacing equal", kind: .toggleSwitch(current: options.keepVerticalSpacingEqual) { n in
                update { $0.keepVerticalSpacingEqual = n }
                }),
            .init(title: "Keep horizontal spacing equal", kind: .toggleSwitch(current: options.keepHorizontalSpacingEqual) { n in
                update { $0.keepHorizontalSpacingEqual = n }
                }),
            .init(title: "Scale curve", kind: .segmented(options: TransformCurve.all.map(\.name), current: options.scaleCurve.name) { n in
                update { $0.scaleCurve = .by(name: n)! }
                }),
            .init(title: "Translation curve", kind: .segmented(options: TransformCurve.all.map(\.name), current: options.translationCurve.name) { n in
                update { $0.translationCurve = .by(name: n)! }
                }),
            .init(title: "Shadow enabled", kind: .toggleSwitch(current: options.shadowEnabled) { n in
                update { $0.shadowEnabled = n }
                }),
            .init(title: "Shadow opacity", kind: .singleSlider(current: CGFloat(options.shadowOpacity)) { n in
                update { $0.shadowOpacity = Float(n!) }
                }),
            .init(title: "Shadow opacity min", kind: .singleSlider(current: CGFloat(options.shadowOpacityMin)) { n in
                update { $0.shadowOpacityMin = Float(n!) }
                }),
            .init(title: "Shadow opacity max", kind: .singleSlider(current: CGFloat(options.shadowOpacityMax)) { n in
                update { $0.shadowOpacityMax = Float(n!) }
                }),
            .init(title: "Shadow radius max", kind: .singleSlider(current: options.shadowRadiusMax, range: 0...15) { n in
                update { $0.shadowRadiusMax = n! }
                }),
            .init(title: "Shadow radius min", kind: .singleSlider(current: options.shadowRadiusMin, range: 0...15) { n in
                update { $0.shadowRadiusMin = n! }
                }),
            .init(title: "Shadow offset min", kind: .doubleSlider(current: options.shadowOffsetMin.pair, range: -7...7) { n in
                update { $0.shadowOffsetMin = .by(pair: n!) }
                }),
            .init(title: "Shadow offset max", kind: .doubleSlider(current: options.shadowOffsetMax.pair, range: -7...7) { n in
                update { $0.shadowOffsetMax = .by(pair: n!) }
                }),
            .init(title: "Blur effect enabled", kind: .toggleSwitch(current: options.blurEffectEnabled) { n in
                update { $0.blurEffectEnabled = n }
                }),
            .init(title: "Blur effect radius ratio", kind: .singleSlider(current: options.blurEffectRadiusRatio) { n in
                update { $0.blurEffectRadiusRatio = n! }
                }),
            .init(title: "Blur effect style", kind: .segmented(options: UIBlurEffect.Style.all.map(\.name), current: options.blurEffectStyle.name) { n in
                update { $0.blurEffectStyle = .by(name: n)! }
                })
        ]
        
        let originalRotation3dOptions = options.rotation3d ?? ScaleTransformViewOptions.Rotation3dOptions(
            angle: .pi / 3,
            minAngle: 0,
            maxAngle: .pi,
            x: 0,
            y: 1,
            z: 0,
            m34: -0.000_1
        )
        
        let rotation3dOptions: [LayoutDesignerOptionViewModel] = [
            .init(title: "Enabled", kind: .toggleSwitch(current: options.rotation3d != nil) { n in
                update { $0.rotation3d = !n ? nil : originalRotation3dOptions }
                }),
            .init(title: "Angle", kind: .singleSlider(current: options.rotation3d?.angle, range: -.pi...CGFloat.pi) { n in
                update { $0.rotation3d?.angle = n! }
                }),
            .init(title: "Min angle", kind: .singleSlider(current: options.rotation3d?.minAngle, range: -.pi...CGFloat.pi) { n in
                update { $0.rotation3d?.minAngle = n! }
                }),
            .init(title: "Max angle", kind: .singleSlider(current: options.rotation3d?.maxAngle, range: -.pi...CGFloat.pi) { n in
                update { $0.rotation3d?.maxAngle = n! }
                }),
            .init(title: "X", kind: .singleSlider(current: options.rotation3d?.x, range: -1...1) { n in
                update { $0.rotation3d?.x = n! }
                }),
            .init(title: "Y", kind: .singleSlider(current: options.rotation3d?.y, range: -1...1) { n in
                update { $0.rotation3d?.y = n! }
                }),
            .init(title: "Z", kind: .singleSlider(current: options.rotation3d?.z, range: -1...1) { n in
                update { $0.rotation3d?.z = n! }
                }),
            .init(title: "m34", kind: .singleSlider(current: options.rotation3d.map { $0.m34 * 1_000 }, range: -2...2) { n in
                update { $0.rotation3d?.m34 = n! / 1_000 }
                })
        ]
        
        let originalTranslation3dOptions = options.translation3d ?? ScaleTransformViewOptions.Translation3dOptions(
            translateRatios: (0.1, 0, 0),
            minTranslateRatios: (-0.05, 0, 0.86),
            maxTranslateRatios: (0.05, 0, -0.86)
        )
        
        let translation3dOptions: [LayoutDesignerOptionViewModel] = [
            .init(title: "Enabled", kind: .toggleSwitch(current: options.translation3d != nil) { n in
                update { $0.translation3d = !n ? nil : originalTranslation3dOptions }
                }),
            .init(title: "X ratio", kind: .singleSlider(current: options.translation3d?.translateRatios.0, range: -5...5) { n in
                update {
                    guard let current = $0.translation3d?.translateRatios else { return }
                    $0.translation3d?.translateRatios = (n!, current.1, current.2)
                }
                }),
            .init(title: "X min ratio", kind: .singleSlider(current: options.translation3d?.minTranslateRatios.0, range: -10...10) { n in
                update {
                    guard let current = $0.translation3d?.minTranslateRatios else { return }
                    $0.translation3d?.minTranslateRatios = (n!, current.1, current.2)
                }
                }),
            .init(title: "X max ratio", kind: .singleSlider(current: options.translation3d?.maxTranslateRatios.0, range: -10...10) { n in
                update {
                    guard let current = $0.translation3d?.maxTranslateRatios else { return }
                    $0.translation3d?.maxTranslateRatios = (n!, current.1, current.2)
                }
                }),
            .init(title: "Y ratio", kind: .singleSlider(current: options.translation3d?.translateRatios.1, range: -5...5) { n in
                update {
                    guard let current = $0.translation3d?.translateRatios else { return }
                    $0.translation3d?.translateRatios = (current.0, n!, current.2)
                }
                }),
            .init(title: "Y min ratio", kind: .singleSlider(current: options.translation3d?.minTranslateRatios.1, range: -10...10) { n in
                update {
                    guard let current = $0.translation3d?.minTranslateRatios else { return }
                    $0.translation3d?.minTranslateRatios = (current.0, n!, current.2)
                }
                }),
            .init(title: "Y max ratio", kind: .singleSlider(current: options.translation3d?.maxTranslateRatios.1, range: -10...10) { n in
                update {
                    guard let current = $0.translation3d?.maxTranslateRatios else { return }
                    $0.translation3d?.maxTranslateRatios = (current.0, n!, current.2)
                }
                }),
            .init(title: "Z ratio", kind: .singleSlider(current: options.translation3d?.translateRatios.2, range: -5...5) { n in
                update {
                    guard let current = $0.translation3d?.translateRatios else { return }
                    $0.translation3d?.translateRatios = (current.0, current.1, n!)
                }
                }),
            .init(title: "Z min ratio", kind: .singleSlider(current: options.translation3d?.minTranslateRatios.2, range: -10...10) { n in
                update {
                    guard let current = $0.translation3d?.minTranslateRatios else { return }
                    $0.translation3d?.minTranslateRatios = (current.0, current.1, n!)
                }
                }),
            .init(title: "Z max ratio", kind: .singleSlider(current: options.translation3d?.maxTranslateRatios.2, range: -10...10) { n in
                update {
                    guard let current = $0.translation3d?.maxTranslateRatios else { return }
                    $0.translation3d?.maxTranslateRatios = (current.0, current.1, n!)
                }
                })
        ]
        
        
        return [
            .init(title: "Options", items: generalOptions),
            .init(title: "Rotation 3D options", items: rotation3dOptions),
            .init(title: "Translation 3D options", items: translation3dOptions)
        ]
    }
    
    private func getOptionViewModels(stackOptions: StackTransformViewOptions) -> [LayoutDesignerOptionSectionViewModel] {
        var options = stackOptions
        updateCodePreview(options: options)
        let update: ((inout StackTransformViewOptions) -> Void) -> Void = {  [weak self] in
            self?.update(options: &options, closure: $0)
        }
        
        let viewModels: [LayoutDesignerOptionViewModel] = [
            .init(title: "Scale factor", kind: .singleSlider(current: options.scaleFactor, range: -1...1) { n in
                update { $0.scaleFactor = n! }
                }),
            .init(title: "Min scale", kind: .singleSlider(current: options.minScale, optional: true) { n in
                update { $0.minScale = n }
                }),
            .init(title: "Max scale", kind: .singleSlider(current: options.maxScale, optional: true) { n in
                update { $0.maxScale = n }
                }),
            .init(title: "Spacing factor", kind: .singleSlider(current: options.spacingFactor, range: 0...0.5) { n in
                update { $0.spacingFactor = n! }
                }),
            .init(title: "Max spacing", kind: .singleSlider(current: options.maxSpacing, optional: true) { n in
                update { $0.maxSpacing = n }
                }),
            .init(title: "Alpha factor", kind: .singleSlider(current: options.alphaFactor) { n in
                update { $0.alphaFactor = n! }
                }),
            .init(title: "Bottom stack alpha speed factor", kind: .singleSlider(current: options.bottomStackAlphaSpeedFactor, range: 0...10) { n in
                update { $0.bottomStackAlphaSpeedFactor = n! }
                }),
            .init(title: "Top stack alpha speed factor", kind: .singleSlider(current: options.topStackAlphaSpeedFactor, range: 0...10) { n in
                update { $0.topStackAlphaSpeedFactor = n! }
                }),
            .init(title: "Perspective ratio", kind: .singleSlider(current: options.perspectiveRatio, range: -1...1) { n in
                update { $0.perspectiveRatio = n! }
                }),
            .init(title: "Shadow enabled", kind: .toggleSwitch(current: options.shadowEnabled) { n in
                update { $0.shadowEnabled = n }
                }),
            .init(title: "Shadow opacity", kind: .singleSlider(current: CGFloat(options.shadowOpacity)) { n in
                update { $0.shadowOpacity = Float(n!) }
                }),
            .init(title: "Shadow offset", kind: .doubleSlider(current: options.shadowOffset.pair) { n in
                update { $0.shadowOffset = .by(pair: n!) }
                }),
            .init(title: "Shadow radius", kind: .singleSlider(current: options.shadowRadius, range: 1...10) { n in
                update { $0.shadowRadius = n! }
                }),
            .init(title: "Rotate angel", kind: .singleSlider(current: options.stackRotateAngel, range: -CGFloat.pi...CGFloat.pi) { n in
                update { $0.stackRotateAngel = n! }
                }),
            .init(title: "Pop angle", kind: .singleSlider(current: options.popAngle, range: -CGFloat.pi...CGFloat.pi) { n in
                update { $0.popAngle = n! }
                }),
            .init(title: "Pop offset ratio", kind: .doubleSlider(current: options.popOffsetRatio.pair, range: -2...2) { n in
                update { $0.popOffsetRatio = .by(pair: n!) }
                }),
            .init(title: "Stack position", kind: .doubleSlider(current: options.stackPosition.pair, range: -1...1) { n in
                update { $0.stackPosition = .by(pair: n!) }
                }),
            .init(title: "Reverse", kind: .toggleSwitch(current: options.reverse) { n in
                update { $0.reverse = n }
                }),
            .init(title: "Blur effect enabled", kind: .toggleSwitch(current: options.blurEffectEnabled) { n in
                update { $0.blurEffectEnabled = n }
                }),
            .init(title: "Max blur radius", kind: .singleSlider(current: options.maxBlurEffectRadius) { n in
                update { $0.maxBlurEffectRadius = n! }
                }),
            .init(title: "Blur effect style", kind: .segmented(options: UIBlurEffect.Style.all.map(\.name), current: options.blurEffectStyle.name) { n in
                update { $0.blurEffectStyle = .by(name: n)! }
                })
        ]
        
        return [
            .init(title: "Options", items: viewModels)
        ]
    }
    
    private func getOptionViewModels(snapshotOptions: SnapshotTransformViewOptions) -> [LayoutDesignerOptionSectionViewModel] {
        var options = snapshotOptions
        updateCodePreview(options: options)
        
        let update: ((inout SnapshotTransformViewOptions) -> Void) -> Void = {  [weak self] in
            self?.update(options: &options, closure: $0)
        }
        let viewModels: [LayoutDesignerOptionViewModel] = [
            .init(title: "Piece size ratio", kind: .doubleSlider(current: options.pieceSizeRatio.pair, range: 0.01...1) { n in
                update { $0.pieceSizeRatio = .by(pair: n!) }
                }),
            .init(title: "Container scale ratio", kind: .singleSlider(current: options.containerScaleRatio) { n in
                update { $0.containerScaleRatio = n! }
                }),
            .init(title: "Container translation ratio", kind: .doubleSlider(current: options.containerTranslationRatio.pair, range: 0...2) { n in
                update { $0.containerTranslationRatio = .by(pair: n!) }
                }),
            .init(title: "Container min translation ratio", kind: .doubleSlider(current: options.containerMinTranslationRatio?.pair, range: 0...2, optional: true) { n in
                update { $0.containerMinTranslationRatio = n.map { .by(pair: $0) } }
                }),
            .init(title: "Container max translation ratio", kind: .doubleSlider(current: options.containerMaxTranslationRatio?.pair, range: 0...2, optional: true) { n in
                update { $0.containerMaxTranslationRatio = n.map { .by(pair: $0) } }
                })
        ]
        return [
            .init(title: "Options", items: viewModels)
        ]
    }
}
