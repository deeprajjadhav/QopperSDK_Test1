//
//  Qopper.swift
//  QAssets
//
//  Created by Mac on 30/09/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

public class Qopper: NSObject {
    
    /// Initializer ///   - TenantID: TenantID ///   - AssetID: AssetID ///   - Source: Source
    public func registerAsset(accessToken:String,tenantID:String,assetID:String,source:String,success:@escaping (_ _asset:QAsset)->Void,failure:@escaping (_ _error:NSDictionary)->Void) {
        ACCESS_TOKEN = accessToken;
        RegisterAsset().register(TenantID: tenantID, AssetID: assetID, Source: source, failure: { (errorDic) in
            failure(errorDic)
        }) { (asset) in
            success(asset)
        }
    }
    
    /// Initializer
    /// - TenantID: TenantID  - AssetID: AssetID  - Product = Product  ///   - Vendor = Vendor ///   - Source: Source
    public func registerAsset(accessToken:String,tenantID:String,assetID:String,product:String,vendor:String,source:String,success:@escaping (_ _asset:QAsset)->Void,failure:@escaping (_ _error:NSDictionary)->Void) {
        ACCESS_TOKEN = accessToken;
        RegisterAsset().register(TenantID: tenantID, AssetID: assetID, Source: source, Product: product, Vendor: vendor, failure: { (errorDic) in
            failure(errorDic)
        }) { (asset) in
            success(asset)
        }
    }
}
