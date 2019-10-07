//
//  SendHeartBeats.swift
//  QAssets
//
//  Created by Mac on 25/09/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class SendHeartBeats: NSObject {
    public func send(asset:QAsset,failure:@escaping (_ _error:NSDictionary)->Void,completion:@escaping (_ response:NSDictionary)->Void)  {
        let requestDic = NSMutableDictionary()
        requestDic.setValue(Date().millisecondsSince1970, forKey: "heartbeat")
        let url = "\(ALLOY_V1_BASE_URL)namespaces/\(asset.locationNamespace)/assets/\(asset.namespace)/heartbeat"
        postResponse(url, strBody: requestDic, failure: { (errorDic) in
            failure(errorDic)
        }) { (response) in
            completion(response)
        }
    }
}
extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
