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

            let code = generateCode(options: options)
            let layoutOptions = ScaleTransformViewOptions.Layout.allCases
                .map { (options: ScaleTransformViewOptions.layout($0), layout: $0) }
                .first { generateCode(options: $0.options) == code }
            if let layoutOptions = layoutOptions {
                return """
                       var scaleOptions: ScaleTransformViewOptions {
                           .layout(.\(layoutOptions.layout.rawValue))
                       }
                       """
            }
            return code

        } else if let options = options as? StackTransformViewOptions {
            
            let code = generateCode(options: options)
            let layoutOptions = StackTransformViewOptions.Layout.allCases
                .map { (options: StackTransformViewOptions.layout($0), layout: $0) }
                .first { generateCode(options: $0.options) == code }
            if let layoutOptions = layoutOptions {
                return """
                       var stackOptions: StackTransformViewOptions {
                           .layout(.\(layoutOptions.layout.rawValue))
                       }
                       """
            }
            return code

        } else if let options = options as? SnapshotTransformViewOptions {

            let code = generateCode(options: options)
            let layoutOptions = SnapshotTransformViewOptions.Layout.allCases
                .map { (options: SnapshotTransformViewOptions.layout($0), layout: $0) }
                .first { generateCode(options: $0.options) == code }
            if let layoutOptions = layoutOptions {
                return """
                       var snapshotOptions: SnapshotTransformViewOptions {
                           .layout(.\(layoutOptions.layout.rawValue))
                       }
                       """
            }
            return code
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
            blurEffectStyle: \(options.blurEffectStyle.generateInitCode())
        )
        """
    }
    
    private func generateCode(options: SnapshotTransformViewOptions) -> String {
        """
        var snapshotOptions = SnapshotTransformViewOptions(
            pieceSizeRatio: \(options.pieceSizeRatio.generateInitCode()),
            piecesCornerRadiusRatio: \(options.piecesCornerRadiusRatio.generateInitCode()),
            piecesAlphaRatio: \(options.piecesAlphaRatio.generateInitCode()),
            piecesTranslationRatio: \(options.piecesTranslationRatio.generateInitCode()),
            piecesScaleRatio: \(options.piecesScaleRatio.generateInitCode()),
            containerScaleRatio: \(options.containerScaleRatio.format()),
            containerTranslationRatio: \(options.containerTranslationRatio.generateInitCode())
        )
        """
    }
}


private extension SnapshotTransformViewOptions.PiecesValue {
    func generateInitCode() -> String {
        switch self {
        case let .static(value):
            return ".static(\(formatValue(value)))"
        case let .columnBased(value, reversed):
            return """
            .columnBased(
                    \(formatValue(value)),
                    reversed: \(reversed ? "true" : "false")
                )
            """
        case let .rowBased(value, reversed):
            return """
            .rowBased(
                    \(formatValue(value)),
                    reversed: \(reversed ? "true" : "false")
                )
            """
        case let .columnOddEven(odd, even, increasing):
            return """
            .columnOddEven(
                    \(formatValue(odd)),
                    \(formatValue(even)),
                    increasing: \(increasing ? "true" : "false")
                )
            """
        case let .rowOddEven(odd, even, increasing):
            return """
            .rowOddEven(
                    \(formatValue(odd)),
                    \(formatValue(even)),
                    increasing: \(increasing ? "true" : "false")
                )
            """
        case let .columnBasedMirror(value, reversed):
            return """
            .columnBasedMirror(
                    \(formatValue(value)),
                    reversed: \(reversed ? "true" : "false")
                )
            """
        case let .rowBasedMirror(value, reversed):
            return """
            .rowBasedMirror(
                    \(formatValue(value)),
                    reversed: \(reversed ? "true" : "false")
                )
            """
        case let .indexBasedCustom(values):
            return ".indexBasedCustom(\(values.map { formatValue($0) }.joined(separator: ", ")))"
        case let .rowBasedCustom(values):
            return ".rowBasedCustom(\(values.map { formatValue($0) }.joined(separator: ", ")))"
        case let .columnBasedCustom(values):
            return ".columnBasedCustom(\(values.map { formatValue($0) }.joined(separator: ", ")))"
        case let .aggregated(piecesValue, _):
            // Custom detection for the functions, I don't think there is a better way for that
            // This works only on the current options
            var function = "+"
            if case .rowBasedMirror(let value, _) = piecesValue.first,
                let point = value as? CGPoint,
                point.x == 1 {
                function = "*"
            }
            return ".aggregated([\(piecesValue.map { $0.generateInitCode() }.joined(separator: ", "))], \(function))"
        }
    }
    
    private func formatValue(_ value: Any) -> String {
        if let value = value as? CGFloat {
            return value.format()
        }
        if let value = value as? CGSize {
            return value.generateInitCode()
        }
        if let value = value as? CGPoint {
            return value.generateInitCode()
        }
        return "-"
    }
}


private extension UIColor {
    func generateInitCode() -> String {
        if self == .black {
            return ".black"
        }
        if self == .white {
            return ".white"
        }
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
                translateRatios: (\(translateRatios.0.format()), \(translateRatios.1.format()), \(translateRatios.2.format())),
                minTranslateRatios: (\(minTranslateRatios.0.format()), \(minTranslateRatios.1.format()), \(minTranslateRatios.2.format())),
                maxTranslateRatios: (\(maxTranslateRatios.0.format()), \(maxTranslateRatios.1.format()), \(maxTranslateRatios.2.format()))
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
                m34: \(m34.format(fractionDigits: 6))
            )
        """
    }
}


private extension CGSize {
    func generateInitCode() -> String {
        if self == .zero { return ".zero" }
        return ".init(width: \(width.format()), height: \(height.format()))"
    }
}


private extension CGPoint {
    func generateInitCode() -> String {
        if self == .zero { return ".zero" }
        return ".init(x: \(x.format()), y: \(y.format()))"
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
