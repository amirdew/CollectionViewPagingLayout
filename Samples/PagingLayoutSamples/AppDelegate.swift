//
//  AppDelegate.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 12/23/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import UIKit
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    var navigationController: UINavigationController!
    
    override init() {
        super.init()
        Catalyst.bridge?.initialise()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        let mainVC = UIDevice.current.userInterfaceIdiom != .phone ?
            LayoutDesignerViewController.instantiate(viewModel: LayoutDesignerViewModel()) :
            MainViewController.instantiate()

        #if targetEnvironment(macCatalyst)
        if let titlebar = window?.windowScene?.titlebar {
            titlebar.titleVisibility = .hidden
            titlebar.toolbar = nil
        }
        #endif
        navigationController.setViewControllers([mainVC], animated: false)
        window!.rootViewController = navigationController//UIHostingController(rootView: DevicesView().ignoresSafeArea())
        window!.makeKeyAndVisible()
        return true
    }
}

// add observer for bounds so invalidate layout won't be necessary
// delegate for invalidating or not
// delegate for snapshot to rerender stuff
// vertical horizontal
// fix icon on mac
// add swifui to layout designer
