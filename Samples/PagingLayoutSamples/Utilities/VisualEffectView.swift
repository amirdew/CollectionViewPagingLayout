//
//  VisualEffectView.swift
//  PagingLayoutSamples
//
//  Created by Amir Khorsandi on 14/04/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import SwiftUI
import UIKit

struct VisualEffectView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemUltraThinMaterial

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
