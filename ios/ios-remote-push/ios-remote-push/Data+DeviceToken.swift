//
//  Data+DeviceToken.swift
//  ios-remote-push
//
//  Created by Kushida　Eiji on 2016/12/29.
//  Copyright © 2016年 Kushida　Eiji. All rights reserved.
//

import UIKit

extension Data {
    
    func data2DeviceToken() -> String {
        
        var token = String(format: "%@", self as CVarArg) as String
        let characterSet: CharacterSet = CharacterSet.init(charactersIn: "<>")
        token = token.trimmingCharacters(in: characterSet)
        token = token.replacingOccurrences(of: " ", with: "")
        return token
    }
}
