//
//  OptionsCodeGenerator.swift
//  PagingLayoutSamples
//
//  Created by Amir on 28/06/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Foundation
import CollectionViewPagingLayout

class OptionsCodeGenerator {
    
    // MARK: Public functions
    
    func generateCode<T>(options: T) -> String {
        if let options = options as? ScaleTransformViewOptions {
            return generateCode(options: options)
        } else if let options = options as? StackTransformViewOptions {
            return generateCode(options: options)
        } else if let options = options as? SnapshotTransformViewOptions {
            return generateCode(options: options)
        }
        return ""
    }
    
    // MARK: Private functions
    
    private func generateCode(options: ScaleTransformViewOptions) -> String {
        """
        var scaleOptions = ScaleTransformViewOptions(
            minScale: \(options.minScale.format()),
            maxScale: \(options.maxScale.format()),
            scaleRatio: \(options.scaleRatio.format()),
            translationRatio: \(options.translationRatio.generateInitCode()),
            minTranslationRatio: \(options.minTranslationRatio.map { $0.generateInitCode() } ?? "nil"),
            maxTranslationRatio: \(options.maxTranslationRatio.map { $0.generateInitCode() } ?? "nil"),
            keepVerticalSpacingEqual: \(options.keepVerticalSpacingEqual ? "true" : "false"),
            keepHorizontalSpacingEqual: \(options.keepHorizontalSpacingEqual ? "true" : "false"),
            scaleCurve: \(options.scaleCurve.generateInitCode()),
            translationCurve: \(options.translationCurve.generateInitCode()),
            shadowEnabled: \(options.shadowEnabled ? "true" : "false"),
            shadowColor: \(options.shadowColor.generateInitCode()),
            shadowOpacity: \(CGFloat(options.shadowOpacity).format()),
            shadowRadiusMin: \(options.shadowRadiusMin.format()),
            shadowRadiusMax: \(options.shadowRadiusMax.format()),
            shadowOffsetMin: \(options.shadowOffsetMin.generateInitCode()),
            shadowOffsetMax: \(options.shadowOffsetMax.generateInitCode()),
            shadowOpacityMin: \(CGFloat(options.shadowOpacityMin).format()),
            shadowOpacityMax: \(CGFloat(options.shadowOpacityMax).format()),
            blurEffectEnabled: \(options.blurEffectEnabled ? "true" : "false"),
            blurEffectRadiusRatio: \(options.blurEffectRadiusRatio.format()),
            blurEffectStyle: \(options.blurEffectStyle.generateInitCode()),
            rotation3d: \(options.rotation3d.map { $0.generateInitCode() } ?? "nil"),
            translation3d: \(options.translation3d.map { $0.generateInitCode() } ?? "nil")
        )
        """
    }
    
    private func generateCode(options: StackTransformViewOptions) -> String {
        """
        var stackOptions = StackTransformViewOptions(
            scaleFactor: \(options.scaleFactor.format()),
            minScale: \(options.minScale.map { $0.format() } ?? "nil"),
            maxScale: \(options.maxScale.map { $0.format() } ?? "nil"),
            maxStackSize: \(options.maxStackSize),
            spacingFactor: \(options.spacingFactor.format()),
            maxSpacing: \(options.maxSpacing.map { $0.format() } ?? "nil"),
            alphaFactor: \(options.alphaFactor.format()),
            bottomStackAlphaSpeedFactor: \(options.bottomStackAlphaSpeedFactor.format()),
            topStackAlphaSpeedFactor: \(options.topStackAlphaSpeedFactor.format()),
            perspectiveRatio: \(options.perspectiveRatio.format()),
            shadowEnabled: \(options.shadowEnabled ? "true" : "false"),
            shadowColor: \(options.shadowColor.generateInitCode()),
            shadowOpacity: \(CGFloat(options.shadowOpacity).format()),
            shadowOffset: \(options.shadowOffset.generateInitCode()),
            shadowRadius: \(options.shadowRadius.format()),
            stackRotateAngel: \(options.stackRotateAngel.format()),
            popAngle: \(options.popAngle.format()),
            popOffsetRatio: \(options.popOffsetRatio.generateInitCode()),
            stackPosition: \(options.stackPosition.generateInitCode()),
            reverse: \(options.reverse ? "true" : "false"),
            blurEffectEnabled: \(options.blurEffectEnabled ? "true" : "false"),
            maxBlurEffectRadius: \(options.maxBlurEffectRadius.format()),
            blurEffectStyle: \(options.blurEffectStyle.generateInitCode()),
        )
        """
    }
    
    private func generateCode(options: SnapshotTransformViewOptions) -> String {
        ""
    }
}


private extension UIColor {
    func generateInitCode() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return ".init(red: \(red.format()), green: \(green.format()), blue: \(blue.format()), alpha: \(alpha.format()))"
    }
}


private extension ScaleTransformViewOptions.Translation3dOptions {
    func generateInitCode() -> String {
        """
        .init(
                translateRatios: (\(translateRatios.0), \(translateRatios.1), \(translateRatios.2)),
                minTranslates: (\(minTranslates.0), \(minTranslates.1), \(minTranslates.2)),
                maxTranslates: (\(maxTranslates.0), \(maxTranslates.1), \(maxTranslates.2))
            )
        """
    }
}


private extension ScaleTransformViewOptions.Rotation3dOptions {
    func generateInitCode() -> String {
        """
        .init(
                angle: \(angle.format()),
                minAngle: \(minAngle.format()),
                maxAngle: \(maxAngle.format()),
                x: \(x.format()),
                y: \(y.format()),
                z: \(z.format()),
                m34: \(m34.format())
            )
        """
    }
}


private extension CGSize {
    func generateInitCode() -> String {
        ".init(width: \(width.format()), height: \(height.format()))"
    }
}


private extension CGPoint {
    func generateInitCode() -> String {
        ".init(x: \(x.format()), y: \(y.format()))"
    }
}


private extension TransformCurve {
    func generateInitCode() -> String {
        ".\(name.prefix(1).lowercased() + name.dropFirst())"
    }
}

private extension UIBlurEffect.Style {
    func generateInitCode() -> String {
        ".\(name.prefix(1).lowercased() + name.dropFirst())"
    }
}
