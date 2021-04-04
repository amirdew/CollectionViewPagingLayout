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

    var body: some View {
        TransformPageView(devices, id: \.name) { device, progress in
            ZStack {
                roundedRectangle(color: device.color, progress: progress)
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
        }
        .collectionView(\.showsHorizontalScrollIndicator, false)
        .zPosition { progress -> Int in
//            if progress > -1.5 && progress < -1 {
//                return 3
//            }
//
//            if progress >= 2 || progress < -1 {
//                return -10
//            }
//            if progress <= 1, progress >= 0 {
//                if progress < 0.5 {
//                    return 1
//                }
//                return 4
//            }
//
//            return 2

            if progress < -1 { return 3 }
            if progress < 0 { return 2 }
            if progress < 0.5 { return 1 }
            if progress <= 1 { return 4 }
            if progress < 2 { return 2 }
            return -1
            //          -1   0  0.5  1   2
            //        3    2   1   4   2   -1
        }
    }

    func roundedRectangle(color: Color, progress: CGFloat) -> some View {
        let scale = getScale(progress)
        return RoundedRectangle(cornerRadius: 80 * ((0.2 * scaleFactor) / scale))
            .fill()
            .frame(width: 80, height: 80)
            .scaleEffect(scale, anchor: getAnchor(progress))
            .transformEffect(
                .init(
                    translationX: getTranslateX(progress: progress),
                    y: 0
                )
            )
            .padding(.top, 400)
            .foregroundColor(color)
            .opacity(getOpacity(progress))
    }

    func getOpacity(_ progress: CGFloat) -> Double {
//        if progress < -0.99 {
//            let p = 1 + max(progress, -1)
//            return Double(p) / 0.01
//        }
        if 1 <= progress, progress <= 1.5 {
            if progress < 1.25 {
                return Double((1.25 - progress) / 0.25)
            }
            return 0
        }
        if progress <= -1 {
            let progress = max(progress, -1.25)
            return Double((1.25 + progress) / 0.25)
        }
        return 1
    }

    func getTranslateX(progress: CGFloat) -> CGFloat {
        if -1 < progress, progress < -0.5 {
            return (1 + progress) * 2 * -80
        } else if 1 <= progress, progress < 1.5 {
            return (1 + progress - 2) * 2 * -80
        }
        return 0
    }

    func getScale(_ progress: CGFloat) -> CGFloat {
        if -1 <= progress, progress < -0.5 {
            return (1 + max(0, 1 + progress) * scaleFactor)
        } else if 1 <= progress, progress < 1.5 {
            return (1 + max(0, 1 + progress - 2) * scaleFactor)
        } else if progress <= 0.5 {
            if progress <= -1 {
                return 1 + (min(1.5, -progress) - 1) * scaleFactor
            }
            return scaleFactor
        } else if 0.5 < progress, progress < 1 {
            return (1 + max(0, 1 - progress) * scaleFactor)
        }
        return 1
    }

    func getAnchor(_ progress: CGFloat) -> UnitPoint {
        if progress <= -0.5 {
            if progress <= -1 {
                return .leading
            }
            return .trailing
        } else if progress < 0.5 {
            return .center
        } else if 1 <= progress, progress < 1.5 {
            return .trailing
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
