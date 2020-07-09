//
//  AppDelegate.swift
//  PagingLayout
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let mainVC = ViewController()
        window = UIWindow()
        window!.rootViewController = mainVC
        window!.makeKeyAndVisible()
        return true
    }


}
