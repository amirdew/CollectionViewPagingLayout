//
//  LayoutDesignerOptionsTableView.swift
//  PagingLayoutSamples
//
//  Created by Amir on 21/05/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

class LayoutDesignerOptionsTableView: UITableView {
    
    // MARK: Properties
    
    var optionViewModels: [LayoutDesignerOptionSectionViewModel] = [] {
        didSet {
            reloadData()
        }
    }
    
    
    // MARK: Lifecycle
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    
    // MARK: Private functions
    
    private func configure() {
        dataSource = self
        delegate = self
        register(LayoutDesignerOptionCell.self)
        backgroundColor = .clear
        separatorStyle = .none
        allowsSelection = false
        sectionHeaderHeight = 40
    }
    
}


extension LayoutDesignerOptionsTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        optionViewModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        optionViewModels[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LayoutDesignerOptionCell = tableView.dequeueReusableCell(for: indexPath)
        cell.viewModel = optionViewModels[indexPath.section].items[indexPath.row]
        return cell
    }
}

extension LayoutDesignerOptionsTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        let label = UILabel()
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.text = optionViewModels[section].title
        header.fill(with: label, edges: .init(top: 5, left: 24, bottom: -3, right: -24))
        header.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.2705882353, blue: 0.8431372549, alpha: 1)
        return header
    }
}
