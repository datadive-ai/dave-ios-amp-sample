//
//  AppDelegate.swift
//  Dave-Sample
//
//  Created by YoungGeun CHOI on 2020/10/19.
//

import UIKit
import AppTrackingTransparency
import AdSupport
import Datadive

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Datadive.instance().trackingSessionEvents = true
        Datadive.instance().initializeApiKey("cd6312957e01361e6c876290f26d9104")
        Datadive.instance().logEvent("open_app")
        
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                Datadive.instance().adSupportBlock = { () -> String in
                    return ASIdentifierManager.shared().advertisingIdentifier.uuidString
                }
            })
        } else {
            // Fallback on earlier versions
        }
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

