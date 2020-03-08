//
//  SnapshotContainerView.swift
//  CollectionViewPagingLayout
//
//  Created by Amir on 07/03/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

public class SnapshotContainerView: UIView {
    
    // MARK: Properties
    
    let snapshots: [UIView]
    let identifier: String
    
    
    // MARK: Lifecycle
    
    init?(targetView: UIView, pieceSize: CGSize, identifier: String) {
        var snapshots: [UIView] = []
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        var width = pieceSize.width
        var height = pieceSize.height
        if width > targetView.frame.width {
            width = targetView.frame.width
        }
        if height > targetView.frame.height {
            height = targetView.frame.height
        }
        while true {
            if y >= targetView.frame.height {
                break
            }
            
            let frame = CGRect(x: x, y: y, width: min(width, targetView.frame.width - x), height: min(height, targetView.frame.height - y))
            if let view = targetView.resizableSnapshotView(from: frame, afterScreenUpdates: true, withCapInsets: .zero) {
                view.frame = frame
                snapshots.append(view)
            }
            x += width
            if x >= targetView.frame.width {
                x = 0
                y += height
            }
            
        }
        if snapshots.isEmpty {
            return nil
        }
        self.identifier = identifier
        self.snapshots = snapshots
        super.init(frame: targetView.frame)
        snapshots.forEach {
            self.addSubview($0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
}
