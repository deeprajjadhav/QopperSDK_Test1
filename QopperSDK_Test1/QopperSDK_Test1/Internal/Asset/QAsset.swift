//
//  QAsset.swift
//  QAsset
//
//  Created by Mac on 09/09/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

/// Protocol : manage for assets
protocol QAssetDelegate : AnyObject{
    func AssetCreated(_ text: String)
    func AssetFailure(_ text: String)
}
/// Model for assets
public class QAsset : NSObject {
    
    private var metrics:[QMetrics]?
    private var properties:[String]?
    private var alerts: [String]?
    
    public let TenantID : String
    public let AssetID : String
    public var Product : String = ""
    public var Vendor : String = ""
    public let Source : String
    public var namespace : String = ""
    public var locationNamespace : String = ""

    /// Initializer
    /// - TenantID: TenantID  - AssetID: AssetID  - Product = Product  ///   - Vendor = Vendor ///   - Source: Source
    public init(TenantID:String,AssetID:String,Product:String,Vendor:String,Source:String,namespace:String,locationNamespace:String) {
        self.TenantID = TenantID
        self.AssetID = AssetID
        self.Product = Product
        self.Vendor = Vendor
        self.Source = Source
        self.namespace = namespace
        self.locationNamespace = locationNamespace
    }
    
    /// Function to get status of assets
    public func getStatus(success:@escaping (_ response:NSDictionary)->Void,failure:@escaping (_ _error:NSDictionary)->Void){
        GetAssetStatus().getStatus(asset: self, failure: { (errorDic) in
            failure(errorDic)
        }) { (responseDic) in
            success(responseDic)
        }
    }
    
    //MARK:- Send asset metrics data
    public func sendProperties(properties:[String:Any],success:@escaping (_ response:NSDictionary)->Void,failure:@escaping (_ _error:NSDictionary)->Void) {
        if Validates().validateProperties(propertiesConfig: self.properties, properties: properties) {
            QSendAssetProperties().sendProperties(asset: self, properties: properties, failure: { (errorDic) in
                failure(errorDic)
            }) { (response) in
                success(response)
            }
        }else{
            let aDict = ["status":"false","developer_message":"Some or all of the Properties are not configured!","code":""]
            failure(aDict as NSDictionary)
        }
    }
    
    //MARK:- Send asset Allets data
    public func sendAlert(alert:Alert,success:@escaping (_ response:NSDictionary)->Void,failure:@escaping (_ _error:NSDictionary)->Void) {
        if Validates().validateAlerts(alertsConfig: self.alerts, alerts: alert) {
            QSendAssetAlerts().sendAlert(asset: self, alert: alert, failure: { (errorDic) in
                failure(errorDic)
            }) { (responseDic) in
                success(responseDic)
            }
        }else{
            let aDict = ["status":"false","developer_message":"Some or all of the Alerts are not configured!","code":""]
            failure(aDict as NSDictionary)
        }
    }
    
    //MARK:- Send asset Metrics data
    public func sendMetrics(metrics:[String:Any],success:@escaping (_ response:NSDictionary)->Void,failure:@escaping (_ _error:NSDictionary)->Void) {
        if Validates().validateMetrics(metricsConfig: self.metrics, metrics: metrics) {
            QSendAssetMetrics().sendMetrics(asset: self, metrics: metrics, failure: { (errorDic) in
                failure(errorDic)
            }) { (response) in
                success(response)
            }
        }else{
            let aDict = ["status":"false","developer_message":"Some or all of the Metrics are not configured!","code":""]
            failure(aDict as NSDictionary)
        }
    }
    
    //MARK:- Send asset Metrics data
    public func sendHeartBeats(success:@escaping (_ response:NSDictionary)->Void,failure:@escaping (_ _error:NSDictionary)->Void) {
        SendHeartBeats().send(asset: self, failure: { (errorDic) in
            failure(errorDic)
        }) { (response) in
            success(response)
        }
    }
    
    public func updateConfig(metrics:[QMetrics],properties:[String] ,alerts: [String],success:@escaping (_ data:NSDictionary)->Void,failure:@escaping (_ _error:NSDictionary)->Void){
        
        self.metrics = metrics
        self.properties = properties
        self.alerts = alerts
        
        let configMetadata = NSMutableDictionary()
        
        for metric in metrics {
            let dataDic = NSMutableDictionary()
            dataDic.setValue(metric.Label, forKey: "label")
            dataDic.setValue(metric.Unit, forKey: "unit")
            dataDic.setValue("METRICS", forKey: "type")
            configMetadata.setValue(dataDic, forKey: metric.Key)
        }
        
        for propertie in properties {
            let dataDic = NSMutableDictionary()
            dataDic.setValue(propertie, forKey: "label")
            dataDic.setValue("PROPERTIES", forKey: "type")
            configMetadata.setValue(dataDic, forKey: propertie)
        }
        
        for alert in alerts {
            let dataDic = NSMutableDictionary()
            dataDic.setValue(alert, forKey: "label")
            dataDic.setValue("ALERTS", forKey: "type")
            configMetadata.setValue(dataDic, forKey: alert)
        }
        
        let requestDic = ["configMetadata":configMetadata]
        let url = "\(ALLOY_V1_BASE_URL)namespaces/\(self.locationNamespace)/assets/\(self.namespace)/properties"
        
        patchResponse(url, strBody: requestDic, failure: { (errorDic) in
            failure(errorDic)
        }) { (response) in
            success(response)
        }
    }
}
