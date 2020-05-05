//
//  Catalyst.swift
//  PagingLayoutSamples
//
//  Created by Amir on 05/05/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Foundation

enum Catalyst {
    static var bridge: AppKitBridge? {
        #if targetEnvironment(macCatalyst)
        guard let url = Bundle.main.builtInPlugInsURL?.appendingPathComponent("AppKitGlue.bundle"),
            let bundle = Bundle(path: url.path),
            bundle.load() else {
            return nil
        }
        guard let principalClass = bundle.principalClass as? NSObject.Type else { return nil }
        guard let appKit = principalClass.init() as? AppKitBridge else { return nil }
        return appKit
        #else
        return nil
        #endif
    }
}
