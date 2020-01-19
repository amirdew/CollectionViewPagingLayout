//
//  CardsViewModel.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 01/10/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import Foundation

class CardsViewModel {
    
    // MARK: Properties
    
    var itemViewModels: [CardCellViewModel] = []
    
    private let cards: [Card] = [
        Card(imageName: "card01"),
        Card(imageName: "card02"),
        Card(imageName: "card06"),
        Card(imageName: "card07"),
        Card(imageName: "card08"),
    ]
    
    
    // MARK: Lifecycle
    
    init() {
        itemViewModels = cards.map { 
            CardCellViewModel(card: $0)
        }
    }
}
