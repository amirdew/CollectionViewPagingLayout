//
//  DevicesView.swift
//  PagingLayoutSamples
//
//  Created by Amir Khorsandi on 30/01/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import SwiftUI
import CollectionViewPagingLayout

struct Device {
    let name: String
    let iconName: String
    let color: Color
}

struct DevicesView: View {

    private let devices: [Device] = [
        Device(name: "Mac Pro", iconName: "macpro.gen3", color: .red),
        Device(name: "iPhone", iconName: "iphone", color: .orange),
        Device(name: "iPad", iconName: "ipad", color: .yellow),
        Device(name: "Apple Watch", iconName: "applewatch", color: .green),
        Device(name: "AirPods Pro", iconName: "airpodspro", color: .blue),
        Device(name: "HomePod", iconName: "homepod", color: .purple)
    ]

    var body: some View {
        TransformPageView(devices, id: \.name) { device, progress in
            ZStack {
                Circle()
                    .fill()
                    .padding()
                    .foregroundColor(device.color)

                VStack {
                    Image(systemName: device.iconName)
                        .font(.system(size: 130))
                    Text(device.name)
                        .font(.system(size: 40))
                }
                .foregroundColor(.white)
                .transformEffect(
                    .init(translationX: 600 * progress, y: 0)
                )
            }
            .scaleEffect(1 - abs(progress - CGFloat(Int(progress))))
            .opacity(1 - abs(Double(progress)))
        }
    }
}


struct DevicesView_Previews: PreviewProvider {
    static var previews: some View {
        DevicesView()
            .ignoresSafeArea()
    }
}
