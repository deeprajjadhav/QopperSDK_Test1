//
//  Alert.swift
//  QAssets
//
//  Created by Mac on 06/09/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

/// Model for Alert
public class Alert: NSObject {
    let data : [String:Any]
    let Status : String
    let Title  : String
    
    /// Initializers
    ///
    /// - Parameters:
    ///   - key: key
    ///   - value: value
    ///   - status: status : online/offline
    ///   - title: title : alert title
    public init(data:[String:Any],status:String,title:String) {
        self.data = data
        self.Status = status
        self.Title = title
    }
}


