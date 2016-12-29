//
//  RemoteNotification.swift
//  ios-remote-push
//
//  Created by Kushida　Eiji on 2016/12/29.
//  Copyright © 2016年 Kushida　Eiji. All rights reserved.
//

import UIKit
import UserNotifications

final class RemoteNotification {
    
    static func setup(application: UIApplication) -> UNUserNotificationCenter{
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if granted {
                //利用許可
                application.registerForRemoteNotifications()
            }
        })
        return center
    }

    static func parse(userInfo: [AnyHashable : Any]) -> APSResult{
        
        var result = APSResult()
        
        if let aps = userInfo["aps"] as? [String: AnyObject] {

            if let alert = aps["alert"] {
                
                result.alert = APSResult.Alert()
                
                if let title = alert["title"] {
                    result.alert?.title = title! as! String
                }
                
                if let subtitle = alert["subtitle"] {
                    result.alert?.subtitle = subtitle! as! String
                }
                
                if let body = alert["body"] {
                    result.alert?.body = body! as! String
                }
            }

            if let sound = aps["sound"] {
                result.sound = sound as! String
            }
            
            if let badge = aps["badge"] {
                result.badge = badge as! Int
            }
        }
    
        return result
    }
}
