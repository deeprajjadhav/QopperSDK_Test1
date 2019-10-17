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
| 12.4.2     |  September 26, 2019 |
| 13.1.3      | October 15, 2019 |

### Libraries

Qopper Edge SDK uses the following libraries

| Library | README |
| ------ | ------ |
| Mixpanel | [plugins/dropbox/README.md][PlDb] |
| GitHub | [plugins/github/README.md][PlGh] |
| Google Analytics | [plugins/googleanalytics/README.md][PlGa] |

### Building from source
For production release:
```sh
$ gulp build --prod
```
Generating pre-built zip archives for distribution:
```sh
$ gulp build dist --prod
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

Qopper().registerAsset(accessToken: <API-ACCESS-TOKEN>,tenantID:<TENANT-ID>, assetID: <ASSET-ID>, product: <PRODUCT>, vendor: <VENDOR>, source: "SDK", success: { (asset) in
            self.SDKAsset = asset
        }) { (errorDic) in
            print(errorDic)
        }
```
###### Return Value
###### Example
###### Errors
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
###### Errors
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
###### Errors
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
###### Errors
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
  ```
###### Return Value
###### Example
###### Errors
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
###### Errors

##### Send HeartBeat
  For send heartbeat user need to call sendHeartBeats method from asset object.
###### Syntax
```Swift
  SDKAsset.sendHeartBeats( success: { (response) in  }) { (error) in }
```
###### Return Value
###### Example
###### Errors
### Todos

 - Test on AWS Device Farm
 - 

License
----

MIT

[//]:#
   [qopper]: <https://www.qopper.com>
   [QopperOne]: <https://www.qopper.com/developer/whyQopper>
 
