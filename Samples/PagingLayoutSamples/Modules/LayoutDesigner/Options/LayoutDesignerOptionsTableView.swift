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
    
    var optionViewModels: [LayoutDesignerOptionCellViewModel] = [] {
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
    }
    
}


extension LayoutDesignerOptionsTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        optionViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LayoutDesignerOptionCell = tableView.dequeueReusableCell(for: indexPath)
        cell.viewModel = optionViewModels[indexPath.row]
        return cell
    }
}

extension LayoutDesignerOptionsTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
}
