//
//  AppDelegate.swift
//  MoveSec2
//
//  Created by Ana Caroline Saraiva Bezerra on 19/11/16.
//  Copyright © 2016 Ana Caroline Saraiva Bezerra. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FIRApp.configure()
        
        //////////Local Notification
        let center = UNUserNotificationCenter.current()
        
        let actions = [UNNotificationAction.init(identifier: "Invasao", title: "Alerta de Invasão", options: UNNotificationActionOptions.foreground)]
        
        let category = UNNotificationCategory(identifier: "Legal", actions: actions, intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([category])
        
        center.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (granted, error) in
            
            if(error != nil){
                print("Local notificações erro!")
            }
            print("Notificações Sucesso!")
            
        })
        
    // UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        ///////////////////////////////////
        
        
        let notType: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
        let notSettings = UIUserNotificationSettings(types: notType, categories: nil)
        
        application.registerForRemoteNotifications()
        application.registerUserNotificationSettings(notSettings)
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    //para notificações
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("MessageID: \(userInfo["gcm_message_id"]!)")
        
        print(userInfo)
    }
//    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        
//        let code = MenuTableViewController()
//        completionHandler(.newData)
//
//        
//    }
    
}

