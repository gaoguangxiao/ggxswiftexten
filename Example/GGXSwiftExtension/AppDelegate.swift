//
//  AppDelegate.swift
//  GGXSwiftExtension
//
//  Created by 小修 on 09/21/2023.
//  Copyright (c) 2023 小修. All rights reserved.
//

import UIKit
import SwiftUI

@main
struct AppOld {
    static func main() {
        if #available(iOS 14.0, *) {
            //启动之前设置配置
            AppNew.main()

        } else {
            UIApplicationMain(
                CommandLine.argc,
                CommandLine.unsafeArgv,
                nil,
                NSStringFromClass(AppDelegate.self))
        }
    }
}


@available(iOS 14.0, *)
struct AppNew: App {
    var body: some Scene {
        WindowGroup {
            SwiftUIQRCodeView()
        }
    }
}

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var orientationMask : UIInterfaceOrientationMask = .portrait
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //
        if #available(iOS 13.0, *) {
            let homepageVc = UIHostingController(rootView: SwiftUIQRCodeView())
            let nav = UINavigationController(rootViewController: homepageVc)
            //        nav.setNavigationBarHidden(true, animated: true)
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
        } else {
            let homepageVc = ViewController()
            // Fallback on earlier versions
            let nav = UINavigationController(rootViewController: homepageVc)
            //        nav.setNavigationBarHidden(true, animated: true)
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientationMask
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

