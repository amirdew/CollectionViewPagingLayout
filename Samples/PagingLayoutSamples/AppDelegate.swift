//
//  AppDelegate.swift
//  CollectionViewPagingLayout
//
//  Created by Amir Khorsandi on 12/23/19.
//  Copyright © 2019 Amir Khorsandi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    var navigationController: UINavigationController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        navigationController.setViewControllers([LayoutDesignerViewController.instantiate()], animated: false)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        
        #if targetEnvironment(macCatalyst)
        if let titlebar = window?.windowScene?.titlebar {
            window?.tintColor = .red
            titlebar.titleVisibility = .hidden
            titlebar.toolbar = nil
        }
        #endif
        DispatchQueue.main.async {
            Catalyst.bridge?.setSize()
        }
        
        return true
    }
    
}
