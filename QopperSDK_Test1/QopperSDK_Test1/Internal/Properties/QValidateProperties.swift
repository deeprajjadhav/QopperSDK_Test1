//
//  QValidateProperties.swift
//  QAssets
//
//  Created by Mac on 04/10/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class Validates: NSObject {
    
    public func validateProperties(propertiesConfig:[String]?,properties:[String:Any]?) -> Bool {
        if propertiesConfig == nil || properties == nil {
            return false
        }
        for key in properties!.keys {
            if !propertiesConfig!.contains(key){
                return false
            }
        }
        return true
    }
    public func validateAlerts(alertsConfig:[String]?,alerts:Alert) -> Bool {
        if alertsConfig == nil {
            return false
        }
        for key in alerts.data.keys {
            if !alertsConfig!.contains(key){
                return false
            }
        }
        return true
    }
    public func validateMetrics(metricsConfig:[QMetrics]?,metrics:[String:Any]?) -> Bool {
        if metricsConfig == nil || metrics == nil{
            return false
        }
        
        var keyArray = [String]()
        for metric in metricsConfig! {
            keyArray.append(metric.Key)
        }
        
        for key in metrics!.keys {
            if !keyArray.contains(key){
                return false
            }
        }
        return true
    }
}
