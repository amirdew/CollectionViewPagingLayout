//
//  LayoutDesignerViewModel.swift
//  PagingLayoutSamples
//
//  Created by Amir on 27/06/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Foundation

class LayoutDesignerViewModel {
    
    // MARK: Properties
    
    var onCodePreviewViewModelChange: ((LayoutDesignerCodePreviewViewModel) -> Void)?
    var selectedLayout: ShapeLayout?
    var layouts: [ShapeLayout] = []
    
    
    // MARK: Public functions
    
    func getPreviewViewModel() -> ShapesViewModel {
        ShapesViewModel(layouts: layouts, showBackButton: false)
    }
    
    func getOptionViewModels() -> [LayoutDesignerOptionCellViewModel] {
        [
            .init(title: "Min scale", kind: .singleSlider(current: 0.3, onChange: { _ in })),
            .init(title: "Scale ratio", kind: .singleSlider(current: 0.7, onChange: { _ in })),
            .init(title: "Translate ratio", kind: .doubleSlider(current: (0.2, 0.7), onChange: { _, _  in })),
            .init(title: "Keep vertical spacing equal", kind: .toggleSwitch(current: true, onChange: { _ in })),
            .init(title: "Keep horizontal spacing equal", kind: .toggleSwitch(current: false, onChange: { _ in })),
            .init(title: "Scale curve", kind: .segmented(options: ["Linear", "EaseIn", "EeaseOut"], current: "Linear", onChange: { _ in }))
        ]
    }
}
