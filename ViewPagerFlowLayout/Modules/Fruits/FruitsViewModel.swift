//
//  FruitsViewModel.swift
//  ViewPagerFlowLayout
//
//  Created by Amir Khorsandi on 12/23/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import Foundation

class FruitsViewModel {
    
    var items: [Fruit] = Array(repeating: Fruit(
        title: "Tommy Atkins",
          description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
          isVegan: true,
          price: 1.68,
          priceType: .unit,
          tintColor: #colorLiteral(red: 1, green: 0.7647058824, blue: 0, alpha: 1),
          imageName: "mangoImage"
    ), count: 10)
}
