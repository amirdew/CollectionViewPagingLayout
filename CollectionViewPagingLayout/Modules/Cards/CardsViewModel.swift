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
    
    private let photos: [Photo] = [
        Photo(imageName: "galleryImage07", title: "Oksana", authorName: "Dmitry Simakovichr"),
        Photo(imageName: "galleryImage03", title: "Christmas", authorName: "Lukáš Kuda"),
        Photo(imageName: "galleryImage08", title: "Touch You", authorName: "Dmitry Simakovichr"),
        Photo(imageName: "galleryImage02", title: "Above the Fjord", authorName: "Wim Lassche"),
        Photo(imageName: "galleryImage01", title: "Milena", authorName: "Edith Laurent-Neuhauser"),
        Photo(imageName: "galleryImage05", title: "Portrait Anya", authorName: "Dmitry Simakovich"),
        Photo(imageName: "galleryImage04", title: "Almsee", authorName: "Michael Gruber"),
        Photo(imageName: "galleryImage06", title: "Piz Beverin", authorName: "Michael Mettier")
    ]
    
    
    // MARK: Lifecycle
    
    init() {
        itemViewModels = photos.map { 
            CardCellViewModel(title: $0.title)
        }
    }
}
