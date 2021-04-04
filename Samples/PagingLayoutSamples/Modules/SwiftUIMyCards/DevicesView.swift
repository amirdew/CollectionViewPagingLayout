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
        Device(name: "iPad", iconName: "ipad", color: .yellow),
        Device(name: "Apple Watch", iconName: "applewatch", color: .green),
        Device(name: "iPhone", iconName: "iphone", color: .orange),
        Device(name: "AirPods Pro", iconName: "airpodspro", color: .blue),
        Device(name: "Mac Pro", iconName: "macpro.gen3", color: .red),
        Device(name: "HomePod", iconName: "homepod", color: .purple)
    ]

    private let scaleFactor: CGFloat = 130
    private let circleSize: CGFloat = 80

    var body: some View {
        TransformPageView(devices, id: \.name) { device, progress in
            ZStack {
                roundedRectangle(color: device.color, progress: progress)
                deviceView(device: device, progress: progress)
            }
        }
        .animator(DefaultViewAnimator(0.9, curve: .parametric))
        .zPosition(zPosition)
        .collectionView(\.showsHorizontalScrollIndicator, false)
    }

    private func deviceView(device: Device, progress: CGFloat) -> some View {
        VStack {
            Image(systemName: device.iconName)
                .font(.system(size: 160))
            Text(device.name)
                .font(.system(size: 40))
                .padding(.top, 10)
            Spacer()
                .frame(maxHeight: 200)
        }
        .frame(maxHeight: .infinity)
        .foregroundColor(.white)
        .transformEffect(
            .init(translationX: 375 * progress, y: 0)
        )
        .blur(radius: abs(progress) * 20)
    }

    private func roundedRectangle(color: Color, progress: CGFloat) -> some View {
        let scale = getScale(progress)
        return RoundedRectangle(cornerRadius: circleSize * ((0.2 * scaleFactor) / scale))
            .fill()
            .frame(width: circleSize, height: circleSize)
            .scaleEffect(scale, anchor: scaleAnchor(progress))
            .transformEffect(.init(translationX: translationX(progress), y: 0))
            .padding(.top, 400)
            .foregroundColor(color)
            .opacity((1.25 - max(1, abs(Double(progress)))) / 0.25)
    }

    private func translationX(_ progress: CGFloat) -> CGFloat {
        guard progress >= 1 || progress < -0.5 else { return 0 }
        return -2 * (progress + (progress > 0 ? -1 : 1)) * circleSize
    }

    private func zPosition(_ progress: CGFloat) -> Int {
        if progress < -1 { return 3 }
        if progress < 0 { return 2 }
        if progress < 0.5 { return 1 }
        if progress <= 1 { return 4 }
        if progress < 1.5 { return 2 }
        return -1
    }

    private func getScale(_ progress: CGFloat) -> CGFloat {
        var scale: CGFloat = progress > 1 ? progress - 1 : 1 - progress
        if progress <= -1 {
            scale = -progress - 1
        } else if progress < -0.5 {
            scale = progress + 1
        } else if progress <= 0.5 {
            scale = scaleFactor
        }
        return 1 + scale * scaleFactor
    }

    private func scaleAnchor(_ progress: CGFloat) -> UnitPoint {
        if progress <= -1 { return .leading }
        if progress <= -0.5 { return .trailing }
        if progress < 0.5 { return .center }
        if progress < 1 { return .leading }
        return .trailing
    }
}


struct DevicesView_Previews: PreviewProvider {
    static var previews: some View {
        DevicesView()
            .ignoresSafeArea()
    }
}
