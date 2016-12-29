//
//  AppDelegate.swift
//  ios-remote-push
//
//  Created by Kushida　Eiji on 2016/12/29.
//  Copyright © 2016年 Kushida　Eiji. All rights reserved.
//

import UIKit
import UserNotifications
import ObjectMapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let center = RemoteNotification.setup(application: application)
        center.delegate = self
        return true
    }

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        //本来は、APIでサーバーへ通知する
        print("deviceToken: \(deviceToken.data2DeviceToken())")
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
}

//MARK:-UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // フォアグランドでもアラートを表示する
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        let userInfo = notification.request.content.userInfo

        let result = RemoteNotification.parse(userInfo: userInfo)
        print(result.alert?.title ?? "nodata")
        print(result.sound)
        print(result.badge)
        
        completionHandler([.badge, .sound, .alert])
    }
    
    // Pushをタップした時
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {

        let userInfo = response.notification.request.content.userInfo
        
        let result = RemoteNotification.parse(userInfo: userInfo)
        print(result.alert?.title ?? "nodata")
        print(result.sound)
        print(result.badge)

        completionHandler()
    }
}

