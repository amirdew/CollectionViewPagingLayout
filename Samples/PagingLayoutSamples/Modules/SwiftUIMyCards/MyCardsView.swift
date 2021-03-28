//
//  MyCardsView.swift
//  PagingLayoutSamples
//
//  Created by Amir Khorsandi on 30/01/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import SwiftUI
import CollectionViewPagingLayout

struct MyCardsView: View {

    @State var selectedCardImageName: String?

    private let cards: [Card] = [
        Card(imageName: "card01"),
        Card(imageName: "card02"),
        Card(imageName: "card06"),
        Card(imageName: "card07"),
        Card(imageName: "card08")
    ]

    //    var body: some View {
    //        GeometryReader { geo in
    //            TransformPageView(cards,
    //                              id: \.imageName,
    //                              selection: $selectedCardImageName) { card, progress in
    //                ZStack {
    //                    Image(card.imageName)
    //                    Text(card.imageName)
    //                }
    //                .cornerRadius(17)
    //                .transformEffect(.init(translationX: geo.size.width / 2 * progress, y: 0))
    //                .opacity(1 - abs(Double(progress)))
    //            }
    //            .numberOfVisibleItems(5)
    //            .zPosition {
    //                Int(-abs(round($0)))
    //            }
    //        }
    //        .onChange(of: selectedCardImageName) {
    //            print($0 ?? "")
    //        }
    //        .onAppear {
    //            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    //                selectedCardImageName = "card07"
    //            }
    //        }
    //    }

    var body: some View {
        SnapshotPageView(cards,
                         id: \.imageName,
                         selection: $selectedCardImageName) { card in
            ZStack {
                Image(card.imageName)
                Text(card.imageName)
            }
            .cornerRadius(17)
        }
        .numberOfVisibleItems(5)
        .zPosition {
            Int(-abs(round($0)))
        }
        .onChange(of: selectedCardImageName) {
            print($0 ?? "")
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                selectedCardImageName = "card07"
            }
        }
    }
}
