//
//  CardCellViewModel.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 01/11/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import Foundation

struct CardCellViewModel: Equatable {
    
    let card: Card
    var imageName: String {
        card.imageName
    }
}
