//
//  QProperties.swift
//  QAssets
//
//  Created by Mac on 06/09/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

/// Model for properties
public class QPropertie: NSObject {
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
