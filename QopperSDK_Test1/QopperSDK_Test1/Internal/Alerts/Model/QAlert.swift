//
//  QAlert.swift
//  QAssets
//
//  Created by Mac on 03/10/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

public class QAlert: NSObject {
    let data : [String:Any]
    /// Initializer
    ///
    /// - Parameters:
    ///   - key: key
    ///   - value: value
    public init(data : [String:Any]) {
        self.data = data
    }
}
