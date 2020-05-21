//
//  LayoutDesignerOptionsTableView.swift
//  PagingLayoutSamples
//
//  Created by Amir on 21/05/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import UIKit

class LayoutDesignerOptionsTableView: UITableView {
    
    // MARK: Lifecycle
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    
    // MARK: Private functions
    
    private func configure() {
        dataSource = self
        register(LayoutDesignerOptionCell.self)
        backgroundColor = .clear
        separatorStyle = .none
        allowsSelection = false
    }
    
}


extension LayoutDesignerOptionsTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(for: indexPath) as LayoutDesignerOptionCell
    }
}
