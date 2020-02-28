//
//  AppDelegate.swift
//  bootstrap
//
//  Created by Thomas Allen on 2/19/20.
//  Copyright © 2020 CapTech Consulting. All rights reserved.
//

import UIKit
import Promises
import SwiftyBeaver

// Global var for log instance
let log = SwiftyBeaver.self

//- Declares global app state observable for current session
var GlobalState: AppState = AppState()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var sceneDelegate: UISceneDelegate?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //      Logger configuration
        let console = ConsoleDestination()      // log to Xcode Console
        console.format = "$DHH:mm:ss$d $L $M"   // Sets format of logger
        log.addDestination(console)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

