//
//  FruitsViewModel.swift
//  ViewPagerFlowLayout
//
//  Created by Amir Khorsandi on 12/23/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import Foundation

class FruitsViewModel {
    
    // MARK: Properties
    
    var itemViewModels: [FruitCellViewModel] = []
    
    private let fruits: [Fruit] = [
        Fruit(
            pageTitle: "Mango",
            title: "Tommy Atkins",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
            isVegan: true,
            price: 1.68,
            priceType: .unit,
            tintColor: #colorLiteral(red: 1, green: 0.7647058824, blue: 0, alpha: 1),
            imageName: "mangoImage"
        ),
        Fruit(
            pageTitle: "Apple",
            title: "Green Apple",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
            isVegan: true,
            price: 0.78,
            priceType: .unit,
            tintColor: #colorLiteral(red: 0.6784313725, green: 0.8156862745, blue: 0.2549019608, alpha: 1),
            imageName: "appleImage"
        ),
        Fruit(
            pageTitle: "Cherry",
            title: "Sweet Cherry",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
            isVegan: true,
            price: 3.14,
            priceType: .kilogram,
            tintColor: #colorLiteral(red: 0.8862745098, green: 0.07843137255, blue: 0.1803921569, alpha: 1),
            imageName: "cherryImage"
        ),
        Fruit(
            pageTitle: "Papaya",
            title: "Papaya",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
            isVegan: true,
            price: 4.28,
            priceType: .unit,
            tintColor: #colorLiteral(red: 1, green: 0.4235294118, blue: 0.05882352941, alpha: 1),
            imageName: "papayaImage"
        ),
        Fruit(
            pageTitle: "Berry",
            title: "Blackberry",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
            isVegan: true,
            price: 4.12,
            priceType: .kilogram,
            tintColor: #colorLiteral(red: 0.3294117647, green: 0.231372549, blue: 0.3294117647, alpha: 1),
            imageName: "blackberryImage"
        )
    ]
    
    
    // MARK: Lifecycle
    
    init() {
        itemViewModels = fruits.enumerated().map { index, fruit -> FruitCellViewModel in
            FruitCellViewModel(fruit: fruit, numberOfItems: fruits.count, index: index)
        }
    }
}
