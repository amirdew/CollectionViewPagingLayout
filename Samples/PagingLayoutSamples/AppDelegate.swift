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
        window!.rootViewController = UIHostingController(rootView: DevicesView().ignoresSafeArea())
        window!.makeKeyAndVisible()
        return true
    }
}

// animation duration
// add observer for bounds
// use responder to fix handling touches
// delegate for invalidating or not
// enable paging
// vertical horizontal
