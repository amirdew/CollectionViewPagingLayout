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

//    var body1: some View {
//        TransformPageView(devices, id: \.name) { device, progress in
//            ZStack {
//                Circle()
//                    .fill()
//                    .padding()
//                    .foregroundColor(device.color)
//
//                VStack {
//                    Image(systemName: device.iconName)
//                        .font(.system(size: 130))
//                    Text(device.name)
//                        .font(.system(size: 40))
//                }
//                .foregroundColor(.white)
//                .transformEffect(
//                    .init(translationX: 600 * progress, y: 0)
//                )
//            }
//            .scaleEffect(1 - abs(progress - CGFloat(Int(progress))))
//            .opacity(1 - abs(Double(progress)))
//        }
//    }

    var body: some View {
        TransformPageView(devices, id: \.name) { device, progress in
            ZStack {
                getCircle(color: device.color, progress: progress)
                    //.opacity(Double(progress / 0.5))

                VStack {
                    Image(systemName: device.iconName)
                        .font(.system(size: 130))
                    Text(device.name + " \(String(format: "%.2f", progress))")
                        .font(.system(size: 40))
                    Spacer()
                }
                .frame(height: 600)
                .foregroundColor(.white)
                .transformEffect(
                    .init(translationX: 375 * progress, y: 0)
                )
            }
        }
        .numberOfVisibleItems(4)
        .zPosition { progress -> Int in
            if progress > 1 {
                return -1
            } else if progress <= 1, progress > 0 {
                if progress < 0.5 {
                    return 0
                }
                return 2
            }
            return 1
        }
    }

    func getCircle(color: Color, progress: CGFloat) -> some View {
        let scale = getScale(progress)
        return RoundedRectangle(cornerRadius: 80 * ((0.2 * 130) / scale))
            .fill()
            .frame(width: 80, height: 80)
            .scaleEffect(scale, anchor: getAnchor(progress))
            .transformEffect(.init(translationX: getTranslateX(progress: progress),
                                   y: 0))
            .padding(.top, 400)
            .foregroundColor(color)
    }

    func getTranslateX(progress: CGFloat) -> CGFloat {
        if -1 < progress, progress < -0.5 {
            return (1 + progress) * 2 * -80
        }
        return 0
    }

    func getScale(_ progress: CGFloat) -> CGFloat {
        let scale: CGFloat = 130
        if -1 <= progress, progress < -0.5 {
            return (1 + max(0, 1 + progress) * scale)
        } else if progress < 0.5 {
            return scale
        } else if 0.5 < progress, progress < 1 {
            return (1 + max(0, 1 - progress) * scale)
        }
        return 1
    }

    func getAnchor(_ progress: CGFloat) -> UnitPoint {
        if progress <= -0.5 {
            return .trailing
        } else if progress < 0.5 {
            return .center
        } else {
            return .leading
        }
    }
}


struct DevicesView_Previews: PreviewProvider {
    static var previews: some View {
        DevicesView()
            .ignoresSafeArea()
    }
}
