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
    var sampleProjectTempURL: URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("SampleProject")
    }
    
    private let highlighter = SyntaxHighlighter(format: AttributedStringOutputFormat(theme: .sundellsColors(withFont: Font(size: 12))))
    
    
    // MARK: Public functions
    
    func getHighlightedText(addViewControllerInCode includeVC: Bool) -> NSAttributedString {
        highlighter.highlight(getCode(includeViewController: includeVC))
    }
    
    func generateSampleProject() {
        removeSampleProject()
        guard let sampleProjectTempURL = sampleProjectTempURL,
            let bundlePath = Bundle.main.url(forResource: "SampleProject", withExtension: "bundle"),
            let sampleProjectURL = Bundle(url: bundlePath)?.url(forResource: "SampleProject", withExtension: nil) else {
                return
        }
        try? FileManager.default.copyItem(at: sampleProjectURL, to: sampleProjectTempURL)
        
        let baseProjectPath = sampleProjectTempURL.appendingPathComponent("PagingLayout")
        let viewControllerPath = baseProjectPath.appendingPathComponent("ViewController.swift")
        try? FileManager.default.removeItem(at: viewControllerPath)
        
        let code = getCode(includeViewController: true)
        try? code.write(to: viewControllerPath, atomically: true, encoding: .utf8)
        
        try? FileManager.default.moveItem(at: sampleProjectTempURL.appendingPathComponent("PagingLayout.xcodeproj_sample"),
                                          to: sampleProjectTempURL.appendingPathComponent("PagingLayout.xcodeproj"))
        
        let projectURL = sampleProjectTempURL.appendingPathComponent("PagingLayout.xcodeproj")
        
        try? FileManager.default.moveItem(at: projectURL.appendingPathComponent("project.pbxproj_sample"),
                                          to: projectURL.appendingPathComponent("project.pbxproj"))
        
        try? FileManager.default.moveItem(at: projectURL.appendingPathComponent("project.xcworkspace_sample"),
                                          to: projectURL.appendingPathComponent("project.xcworkspace"))
        
        try? FileManager.default.moveItem(at: baseProjectPath.appendingPathComponent("info_sample.plist"),
                                          to: baseProjectPath.appendingPathComponent("info.plist"))
    }
    
    func removeSampleProject() {
        guard let sampleProjectTempURL = sampleProjectTempURL else {
            return
        }
        try? FileManager.default.removeItem(at: sampleProjectTempURL)
    }
    
    
    // MARK: Private functions
    
    private func getCode(includeViewController: Bool) -> String {
        if !includeViewController {
            return code
        }
        let viewProtocols = ["ScaleTransformView", "StackTransformView", "SnapshotTransformView"]
        let viewProtocolName = viewProtocols.first { code.contains($0) } ?? ""
        
        return """
        import UIKit
        
        // Make sure you added this dependency to your project
        // More info at https://bit.ly/CVPagingLayout
        import CollectionViewPagingLayout
        
        // The cell class needs to conform to `\(viewProtocolName)` protocol
        // to be able to provide the transform options
        class MyCell: UICollectionViewCell, \(viewProtocolName) {
            
            \(code.replacingOccurrences(of: "\n", with: "\n    "))
        
            // The card view that we apply transforms on
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
                // Adjust the card view frame you can use Autolayout too
                let cardFrame = CGRect(x: 80,
                                       y: 100,
                                       width: frame.width - 160,
                                       height: frame.height - 200)
                card = UIView(frame: cardFrame)
                card.backgroundColor = .gray
                contentView.addSubview(card)
            }
        }
        
        // A simple View Controller that filled with a UICollectionView
        // You can use `UICollectionViewController` too
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
                DispatchQueue.main.async { [weak self] in
                    self?.collectionView?.performBatchUpdates({ [weak self] in
                        self?.collectionView?.collectionViewLayout.invalidateLayout()
                    })
                }
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
