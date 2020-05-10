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
    
    override init() {
        super.init()
        Catalyst.bridge?.initialise()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        let mainVC = UIDevice.current.userInterfaceIdiom == .pad ? LayoutDesignerViewController.instantiate() : MainViewController.instantiate()
        navigationController.setViewControllers([mainVC], animated: false)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        return true
    }
}
