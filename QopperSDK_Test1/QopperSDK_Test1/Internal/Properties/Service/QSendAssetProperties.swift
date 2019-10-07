//
//  QSendAssetProperties.swift
//  QAssets
//
//  Created by Mac on 25/09/19.
//  Copyright © 2019 Mac. All rights reserved.
//
import UIKit

class QSendAssetProperties: NSObject {
    /// Function to create properties
    ///
    /// - Parameter Properties: Object of property from Assets
    public func sendProperties(asset:QAsset,properties:[String:Any],failure:@escaping (_ _error:NSDictionary)->Void,completion:@escaping (_ response:NSDictionary)->Void)  {
        let requestDic = ["properties":properties]
        let url = "\(ALLOY_V1_BASE_URL)namespaces/\(asset.locationNamespace)/assets/\(asset.namespace)/properties"
        patchResponse(url, strBody: requestDic, failure: { (errorDic) in
            failure(errorDic)
        }) { (response) in
            completion(response)
        }
    }
}
