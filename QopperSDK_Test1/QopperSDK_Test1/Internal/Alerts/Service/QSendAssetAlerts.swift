//
//  QSendAssetAlerts.swift
//  QAssets
//
//  Created by Mac on 25/09/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class QSendAssetAlerts: NSObject {
    public func sendAlert(asset:QAsset,alert:Alert,failure:@escaping (_ _error:NSDictionary)->Void,completion:@escaping (_ response:NSDictionary)->Void)  {
        let requestDic = NSMutableDictionary()
        requestDic.setValue(alert.Title, forKey: "title")
        requestDic.setValue(alert.Status, forKey: "status")
        requestDic.setValue(alert.data, forKey: "properties")
        let url = "\(ALLOY_V1_BASE_URL)namespaces/\(asset.locationNamespace)/assets/\(asset.namespace)/alerts"
        postResponse(url, strBody: requestDic, failure: { (errorDic) in
            failure(errorDic)
        }) { (response) in
            completion(response)
        }
    }
}
