//
//  RegisterAsset.swift
//  QAssets
//
//  Created by Mac on 25/09/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class RegisterAsset: NSObject {
    
    func register(TenantID:String,AssetID:String,Source:String,Product:String,Vendor:String, failure:@escaping (_ _error:NSDictionary)->Void,completion:@escaping (_ _asset:QAsset)->Void) {
        let url = "\(FORGE_BASE_URL)namespaces/\(TenantID)/assets"
        let reqDict = NSMutableDictionary()
        var responseDict = NSDictionary()
        
        reqDict.setValue(TenantID, forKey: "tenantId")
        reqDict.setValue(AssetID, forKey: "assetId")
        reqDict.setValue(Product, forKey: "product")
        reqDict.setValue(Vendor, forKey: "vendor")
        reqDict.setValue(Source, forKey: "source")
        
        postResponse(url, strBody: reqDict, failure: { (error) in
            responseDict = error.mutableCopy() as? NSDictionary ?? NSDictionary()
            failure(responseDict)
        }) { (response) in
            if (response.value(forKey: "status") as? String ?? "" == "SUCCESS"),let data = response.value(forKey: "data") as? NSDictionary , let namespace = data.value(forKey: "namespace") as? String , let locationNamespace = data.value(forKey: "locationNamespace") as? String {
                let asset = QAsset(TenantID: TenantID, AssetID: AssetID, Product: Product, Vendor: Vendor, Source: Source, namespace: namespace, locationNamespace: locationNamespace)
                completion(asset)
            }else{
                responseDict = response.mutableCopy() as? NSDictionary ?? NSDictionary()
                failure(responseDict)
            }
        }
    }
    
    func register(TenantID:String,AssetID:String,Source:String, failure:@escaping (_ _error:NSDictionary)->Void,completion:@escaping (_ _asset:QAsset)->Void) {
        let url = "\(FORGE_BASE_URL)namespaces/\(TenantID)/assets"
        let reqDict = NSMutableDictionary()
        var responseDict = NSDictionary()
        
        reqDict.setValue(TenantID, forKey: "tenantId")
        reqDict.setValue(AssetID, forKey: "assetId")
        reqDict.setValue("", forKey: "product")
        reqDict.setValue("", forKey: "vendor")
        reqDict.setValue(Source, forKey: "source")
        
        postResponse(url, strBody: reqDict, failure: { (error) in
            responseDict = error.mutableCopy() as? NSDictionary ?? NSDictionary()
            failure(responseDict)
        }) { (response) in
            if (response.value(forKey: "status") as? String ?? "" == "SUCCESS"),let data = response.value(forKey: "data") as? NSDictionary , let namespace = data.value(forKey: "namespace") as? String , let locationNamespace = data.value(forKey: "locationNamespace") as? String {
                let asset = QAsset(TenantID: TenantID, AssetID: AssetID, Product: "", Vendor: "", Source: Source, namespace: namespace, locationNamespace: locationNamespace)
                completion(asset)
            }else{
                responseDict = response.mutableCopy() as? NSDictionary ?? NSDictionary()
                failure(responseDict)
            }
        }
    }
}
