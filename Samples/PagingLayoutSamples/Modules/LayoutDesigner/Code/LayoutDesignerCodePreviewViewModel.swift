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
    
    func getHighlightedText(addViewControllerInCode includeVC: Bool) -> NSAttributedString {
        highlighter.highlight(getCode(includeViewController: includeVC))
    }
    
    
    // MARK: Private functions
    
    func getCode(includeViewController: Bool) -> String {
        if !includeViewController {
            return code
        }
        let viewProtocols = ["ScaleTransformView", "StackTransformView", "SnapshotTransformView"]
        let viewProtocolName = viewProtocols.first { code.contains($0) } ?? ""
        
        return """
        import UIKit
        import CollectionViewPagingLayout
        
        class MyCell: UICollectionViewCell, \(viewProtocolName) {
            
            \(code.replacingOccurrences(of: "\n", with: "\n    "))
        
            var card: UIView!
            
            override init(frame: CGRect) {
                super.init(frame: frame)
                setup()
            }
            
            required init?(coder: NSCoder) {
                super.init(coder: coder)
                setup()
            }
            
            func setup() {
                // preferably use AutoLayout! this is only for simplicity
                let cardFrame = CGRect(x: 80,
                                       y: 100,
                                       width: frame.width - 160,
                                       height: frame.height - 200)
                card = UIView(frame: cardFrame)
                card.backgroundColor = .gray
                contentView.addSubview(card)
            }
        }
        

        class ViewController: UIViewController, UICollectionViewDataSource {
            
            var collectionView: UICollectionView!
            
            override func viewDidLoad() {
                super.viewDidLoad()
                setupCollectionView()
            }
            
            private func setupCollectionView() {
                collectionView = UICollectionView(
                    frame: view.frame,
                    collectionViewLayout: CollectionViewPagingLayout()
                )
                collectionView.isPagingEnabled = true
                collectionView.register(MyCell.self, forCellWithReuseIdentifier: "cell")
                collectionView.dataSource = self
                view.addSubview(collectionView)
            }
            
            override func viewDidLayoutSubviews() {
                super.viewDidLayoutSubviews()
                collectionView?.performBatchUpdates({
                    self.collectionView.collectionViewLayout.invalidateLayout()
                })
            }
            
            func collectionView(
                _ collectionView: UICollectionView,
                numberOfItemsInSection section: Int
            ) -> Int {
                10
            }
            
            func collectionView(
                _ collectionView: UICollectionView,
                cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "cell",
                    for: indexPath
                )
            }
            
        }
        """
    }
    
}
