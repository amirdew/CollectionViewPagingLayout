//
//  Shape.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 2/16/20.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

struct Shape: Identifiable {
    let name: String
    let iconName: String

    var id: String {
        name
    }
}
