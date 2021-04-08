//
//  MacApp.swift
//  AppKitGlue
//
//  Created by Amir on 05/05/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Cocoa
import Combine

class MacApp: NSObject, AppKitBridge {

    private var window: NSWindow!
    private var cancellable: Cancellable!

    func initialise() {
        cancellable = DispatchQueue.main.schedule(after: .init(.now()), interval: .milliseconds(10)) {
            if NSApplication.shared.mainWindow != nil {
                self.window = NSApplication.shared.mainWindow
                self.onMainWindowReady()
            }
        }
    }
    
    private func onMainWindowReady() {
        cancellable.cancel()
        hideToolbar()
        setSize()
        addVisualEffectView()
    }
    
    private func setSize() {
        if window.minSize.width < 1_200 || window.minSize.height < 768 {
            window.minSize = NSSize(width: 1_200, height: 768)
        }
        if window.frame.size.width < window.minSize.width ||
            window.frame.size.height < window.minSize.height {
            let size = NSSize(width: max(window.minSize.width, window.frame.size.width),
                              height: max(window.minSize.height, window.frame.size.height))
            window.setFrame(.init(origin: window.frame.origin, size: size), display: true, animate: true)
        }
    }
    
    private func hideToolbar() {
        window.titleVisibility = .hidden
        window.toolbar = nil
    }

    private func addVisualEffectView() {
        let visualEffectView = NSVisualEffectView(frame: .zero)
        visualEffectView.blendingMode = .behindWindow
        visualEffectView.material = .hudWindow
        visualEffectView.appearance = NSAppearance(named: .vibrantDark)
        window.contentView?.addSubview(visualEffectView, positioned: .below, relativeTo: nil)
        visualEffectView.frame = window.contentView?.bounds ?? .zero
        visualEffectView.autoresizingMask = [.width, .height]
    }
}
