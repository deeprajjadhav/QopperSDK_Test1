# Qopper-SDK

-


## Installing

There are a few options. Choose one, or just figure it out:

- **[CocoaPods](https://cocoapods.org)**

 Add the following line to your Podfile:
 ```ruby
 pod 'QopperSDK_Test1'
 ```
 Run `pod install`, and you are all set.

## Usage

### 1. Create Asset
The developer is expected to create an asset object using the following properties
* Tenant ID (Mandatory): This is the operator tenant destination where they wish to publish the asset. They can decide to pick this from a configuration or hardcode it.
* Asset ID(Mandatory): This is a unique asset ID which has to be assigned to the asset and its scope of uniqueness is limited to the operator tenant. 
* Product(Optional): Product name/ID
* Vendor(Optional): Vendor name/ID
```swift
import QAssets

var SDKAsset : QAsset?

Qopper().registerAsset(accessToken: <API-ACCESS-TOKEN>,tenantID:<TENANT-ID>, assetID: <ASSET-ID>, product: <PRODUCT>, vendor: <VENDOR>, source: "SDK", success: { (asset) in
            self.SDKAsset = asset
        }) { (errorDic) in
            print(errorDic)
        }
```

### 2. Update Qopper configurations
Developer expected to update Qopper configurations once asset is created
* Metrics : User need to create metrics for Qopper Configurations.
```swift
  let metric1 = QMetrics(key: <Key>, unit: <UNIT>, label: LABEL)
  let metric2 = QMetrics(key: <Key>, unit: <UNIT>, label: LABEL)
  ..
  ...
```
* Properties : User need to create properties for Qopper Configurations.
```swift
  let property = ["<FIRST-KEY>","SECOND-KEY>",...]
```
* Alerts : User need to create Alerts for Qopper Configurations.
```swift
  let alert = ["<FIRST-KEY>","SECOND-KEY>",...]
```
* UPDATE QOPPER CONFIG
```swift
  self.SDKAsset?.updateConfig(metrics: [metric1,metric2,..], properties: property, alerts: alert, success: { (response) in }, failure: { (errorDic) in  })
```

### 3. Asset Acknowledgement Callback
  The developer should use a closure to be invoked when a callback is received for transition to either a successful “Commissioned” state or a failed “Decommissioned” state. If the returned state is “Operational” then the SDK should continue to retry at a configured time interval. 

This callback should be facilitated by a checkResult method on the asset object.

If the result is

* “Commissioned”: cache/store the tenant ID and new access token for future calls to the server. At this stage the developer’s code can make calls to send metrics, alerts etc. 

* “Decommissioned”: return the failed state and do not make any further API calls to the server.

```Swift
  SDKAsset.getStatus(success: { (ResponseDictionary) in  }) { (ErrorDictionary) in  }
```

### 4. Push Metrics
For send metrics user need to first create metrics object.
  * User can create metrics object which has the following parameters:
Key (Mandatory)
Value (Mandatory)
```swift
  let metrics = Metrics(["<KEY>":"<VALUE>",
                               "<KEY>":"<VALUE>",
                               "<KEY>":"<VALUE>",
                               ...])
```
  * Send Metrics Object:

  ```swift
    SDKAsset.sendMetrics(metrics:metrics, success: { (response) in  }) { (error) in }
  ```

### 5. Push Alerts

For send alerts user need to first create alert object.
  * User can create alert object which has the following parameters:
     Key (Mandatory)
     Value (Mandatory)
     Status (mandatory): online/offline
     Title (mandatory):alert title

```SWift
  let alert_first = Alerts(key: <KEY>, value: <VALUE>, status: <STATUS>, title: <TITLE>)
```
  * Send Alerts Object:
  ```Swift
    SDKAsset.sendAlert(alert: alert_first, success: { (response) in  }) { (error) in }
  ```

### 6. Push Properties
For send Properties user need to first create Properties object.
  * User can create Properties object which has the following parameters:
Key (Mandatory)
Value (Mandatory)
```swift
  let propertey = Properties(["<KEY>":"<VALUE>",
                               "<KEY>":"<VALUE>",
                               "<KEY>":"<VALUE>",
                               ...])
```
  * Send Properties Object:

  ```swift
    SDKAsset.sendProperties(properties:properties, success: { (response) in  }) { (error) in }
  ```

### 7. Send HeartBeat
  For send heartbeat user need to call sendHeartBeats method from asset object.
```Swift
  SDKAsset.sendHeartBeats( success: { (response) in  }) { (error) in }
```

<!-- ## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate. -->

## License
[MIT](https://choosealicense.com/licenses/mit/)
