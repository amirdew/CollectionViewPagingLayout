//
//  MacApp.swift
//  AppKitGlue
//
//  Created by Amir on 05/05/2020.
//  Copyright © 2020 Amir Khorsandi. All rights reserved.
//

import Cocoa

class MacApp: NSObject, AppKitBridge {
    
    func initialise() {
        DispatchQueue.main.async {
            if NSApplication.shared.mainWindow != nil {
                self.onMainWindowReady()
            }
        }
    }
    
    private func onMainWindowReady() {
        hideToolbar()
        setSize()
    }
    
    private func setSize() {
        guard let window = NSApplication.shared.mainWindow else {
            return
        }
        window.minSize = NSSize(width: 1_024, height: 768)
        window.setFrame(.init(origin: window.frame.origin, size: window.minSize), display: true, animate: true)
    }
    
    private func hideToolbar() {
        if let window = NSApplication.shared.mainWindow {
            window.titleVisibility = .hidden
            window.toolbar = nil
        }
    }
}
