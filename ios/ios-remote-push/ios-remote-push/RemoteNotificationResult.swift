//
//  RemoteNotificationResult.swift
//  ios-remote-push
//
//  Created by Kushida　Eiji on 2016/12/29.
//  Copyright © 2016年 Kushida　Eiji. All rights reserved.
//

import UIKit

struct APSResult {
    var alert: Alert?
    var sound = ""
    var badge = 0
    
    struct Alert {
        var title = ""
        var subtitle = ""
        var body = ""
    }
}
