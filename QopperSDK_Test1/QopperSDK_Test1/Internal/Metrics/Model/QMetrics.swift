//
//  QMetrics.swift
//  QAssets
//
//  Created by Mac on 03/10/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

public class QMetrics: NSObject {
    let Key : String
    var Unit : String
    var Label  : String
    
    /// Initializer
    ///
    /// - Parameters:
    ///   - key: key
    ///   - value: value
    ///   - unit: unit
    ///   - label: label
    public init(key:String,unit:String,label:String) {
        self.Key = key
        self.Unit = unit
        self.Label = label
    }
}
