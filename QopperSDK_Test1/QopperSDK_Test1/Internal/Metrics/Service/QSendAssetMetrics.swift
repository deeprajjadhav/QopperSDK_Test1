//
//  QSendAssetMetrics.swift
//  QAssets
//
//  Created by Mac on 25/09/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class QSendAssetMetrics: NSObject {
    
    public func sendMetrics(asset:QAsset,metrics:[String:Any],failure:@escaping (_ _error:NSDictionary)->Void,completion:@escaping (_ response:NSDictionary)->Void)  {
        let requestDic = ["metrics":[metrics]]
        let url = "\(ALLOY_V1_BASE_URL)namespaces/\(asset.locationNamespace)/assets/\(asset.namespace)/metrics"
        postResponse(url, strBody: requestDic, failure: { (errorDic) in
            failure(errorDic)
        }) { (response) in
            completion(response)
        }
    }
}
