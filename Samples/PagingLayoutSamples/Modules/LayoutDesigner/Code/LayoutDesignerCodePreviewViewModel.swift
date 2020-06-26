//
//  LayoutDesignerCodePreviewViewModel.swift
//  PagingLayoutSamples
//
//  Created by Amir on 26/06/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Foundation
import Splash

struct LayoutDesignerCodePreviewViewModel {
 
    // MARK: Properties
    
    let code: String
    
    private let highlighter = SyntaxHighlighter(format: AttributedStringOutputFormat(theme: .sundellsColors(withFont: Font(size: 14))))
    
    
    // MARK: Public functions
    
    func getHighlightedText() -> NSAttributedString {
        highlighter.highlight(code)
    }
    
}
