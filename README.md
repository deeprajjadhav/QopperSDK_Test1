# Qopper Edge SDK for iOS Devices

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

[Qopper] is an IoT Intelligence platform for development, deployment and management of interconnected embedded systems. You can try [QopperOne], a free rapid IoT development offering to build and rollout automated support, dynamic dashboards, testing harnesses and more in a matter of minutes. 

### New Features

  - Provision your connected device in Qopper
  - Publish metrics, alerts and configuration properties
  - Request device status

### Compatibility

Qopper Edge SDK will work with the following versions of iOS

| Version       | Release Date  |
| ------------- | -----:|
| 1.0.0      | October 18, 2019 |

### Libraries

Qopper Edge SDK uses the following libraries

| Library | README |
| ------ | ------ |
| Mixpanel | [plugins/dropbox/README.md][PlDb] |
| GitHub | [plugins/github/README.md][PlGh] |
| Google Analytics | [plugins/googleanalytics/README.md][PlGa] |

### Installation
### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate Qopper Edge SDK into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'QopperSDK_Test1'
end
```

Then, run the following command:

```bash
$ pod install
```
### Developer Guide
##### Create Asset

The developer is expected to create an asset object using the following properties
* Tenant ID (Mandatory): This is the operator tenant destination where they wish to publish the asset. They can decide to pick this from a configuration or hardcode it.
* Asset ID(Mandatory): This is a unique asset ID which has to be assigned to the asset and its scope of uniqueness is limited to the operator tenant.
* Product(Optional): Product name/ID
* Vendor(Optional): Vendor name/ID

```swift
import QAssets

var SDKAsset : QAsset?

Qopper().registerAsset(accessToken: <API-ACCESS-TOKEN>,tenantID:<TENANT-ID>, assetName: <ASSET-NAME>, product: <PRODUCT>, vendor: <VENDOR>, source: "SDK", success: { (asset) in
            self.SDKAsset = asset
        }) { (errorDic) in
            print(errorDic)
        }
```
###### Return Value
  QAsset class object if success or Error Dictionary if fails.
###### Example
```swift
Qopper().registerAsset(accessToken: "ls9bhpip8pp2empu",tenantID: "guest4652.network.corp", assetName: "Syndicate001", product: "Assassin's Creed", vendor: "Ubisoft", source: "SDK", success: { (asset) in
            self.SDKAsset = asset
        }) { (errorDic) in
            print(errorDic)
        }
```
###### Errors
* Tenant ID, Asset ID, Product or Vendor are syntactically unacceptable to the server. Too long, special characters etc.
* Key or value properties are syntactically unacceptable to the server
##### Update Qopper configurations
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
###### Return Value

###### Example
```swift
let metric = QMetrics(key: "timeStamp", unit: "timeStamp_Unit", label: "timeStamp_Label")
let metric1 = QMetrics(key: "system_mem_total", unit: "system_mem_total_Unit", label: "system_mem_total_Label")
let metric2 = QMetrics(key: "system_disk_free", unit: "system_disk_free_Unit", label: "system_disk_free_Label")
let metric3 = QMetrics(key: "system_load_5", unit: "system_load_5_Unit", label: "system_load_5_Label")
let metric4 = QMetrics(key: "system_cpu_user", unit: "system_cpu_user_Unit", label: "system_cpu_user_Label")

self.SDKAsset?.updateConfig(metrics: [metric,metric1,metric2,metric3,metric4], properties: ["device_model","device_name","system_name","device_orientation","device_udid"], alerts: ["id","response_time"], success: { (response) in }, failure: { (errorDic) in  })
```
###### Errors
* Network Connection Error
* Tenant ID does not exist
* Auth Failed
##### Asset Acknowledgement Callback
  The developer should use a closure to be invoked when a callback is received for transition to either a successful “Commissioned” state or a failed “Decommissioned” state. If the returned state is “Operational” then the SDK should continue to retry at a configured time interval.

This callback should be facilitated by a checkResult method on the asset object.

If the result is

* “Commissioned”: cache/store the tenant ID and new access token for future calls to the server. At this stage the developer’s code can make calls to send metrics, alerts etc.

* “Decommissioned”: return the failed state and do not make any further API calls to the server.

```Swift
  SDKAsset.getStatus(success: { (ResponseDictionary) in  }) { (ErrorDictionary) in  }
```
###### Return Value
###### Example

```Swift
  SDKAsset.getStatus(success: { (ResponseDictionary) in  }) { (ErrorDictionary) in  }
```
###### Errors
* Network Connection Error
* Tenant ID does not exist
* Auth Failed
##### Push Metrics
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
###### Return Value
###### Example
```swift
let metrics = Metrics(["timeStamp":"2018-08-01 10:24:36",
                               "system_mem_total":"8589934592 bytes",
                               "system_disk_free":"29.07 GB",
                               "system_load_5":"2.085449",
                               "system_cpu_user":"9.89%"])

SDKAsset.sendMetrics(metrics:metrics, success: { (response) in  }) { (error) in }
```
###### Errors
* Network Connection Error
* Tenant ID does not exist
* Auth Failed
* Key or value properties are syntactically unacceptable to the server
##### Push Alerts

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
    Var alert_first = Alerts(key: "", value: "", status: "", title: "")
  ```
###### Return Value
###### Example
```Swift
  Var alert_first = Alerts(key: "response_time", value: "3235.8219623565674", status: "ONLINE", title: "Transactions response time in ms")

  SDKAsset.sendAlert(alert: alert_first, success: { (response) in  }) { (error) in }
  ```
###### Errors
* Network Connection Error
* Tenant ID does not exist
* Auth Failed
* Key or value properties are syntactically unacceptable to the server

##### Push Properties
For send Properties user need to first create Properties object.
  * User can create Properties object which has the following parameters:
Key (Mandatory)
Value (Mandatory)
###### Syntax
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
###### Return Value
###### Example

```Swift
let properties = Properties(["device_model":"Test_iPhone",
                                     "device_name":"Mac mini",
                                     "system_name":"Test_iOS",
                                     "device_orientation":"Test_UIDeviceOrientationPortrait",
                                     "device_udid":"Test_2F568FCD-37AB-4A4F-8B0F-53FD15B5C3B1"])
```

###### Errors
* Network Connection Error
* Tenant ID does not exist
* Auth Failed
* Key or value properties are syntactically unacceptable to the server

##### Send HeartBeat
  For send heartbeat user need to call sendHeartBeats method from asset object.
###### Syntax
```Swift
  SDKAsset.sendHeartBeats( success: { (response) in  }) { (error) in }

 ```
###### Return Value
###### Example
```Swift
  SDKAsset.sendHeartBeats( success: { (response) in  }) { (error) in }

 ```
###### Errors
* Network Connection Error
* Tenant ID does not exist
* Auth Failed
### Todos

 - Test on AWS Device Farm
 - 

License
----

MIT

[//]:#
   [qopper]: <https://www.qopper.com>
   [QopperOne]: <https://www.qopper.com/developer/whyQopper>
 
