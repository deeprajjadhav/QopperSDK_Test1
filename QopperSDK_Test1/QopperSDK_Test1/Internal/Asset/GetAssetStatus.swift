//
//  GetAssetStatus.swift
//  QAssets
//
//  Created by Mac on 25/09/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class GetAssetStatus: NSObject {
    
    func getStatus(asset:QAsset,failure:@escaping (_ _error:NSDictionary)->Void,completion:@escaping (_ response:NSDictionary)->Void) {
        if asset.locationNamespace == "" || asset.namespace == "" {
            let aDict = ["status":"false","developer_message":"Invalid input parameters","code":""]
            failure(aDict as NSDictionary)
        }
        
        let url = "\(ALLOY_V1_BASE_URL)namespaces/\(asset.locationNamespace)/assets/\(asset.namespace)/lifecycle?topLevelNamespace=\(asset.TenantID)"
        
        var responseDict = NSDictionary()
        getResponse(url , failure: { (error) in
            responseDict = error.mutableCopy() as! NSDictionary
            completion(responseDict)
        }) { (response) in
            responseDict = response.mutableCopy() as! NSDictionary
            completion(responseDict)
        }
    }
}
