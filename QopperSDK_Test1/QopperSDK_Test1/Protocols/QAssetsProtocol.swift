//
//  QAssetsProtocol.swift
//  QAssets
//
//  Created by Mac on 09/09/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

/// Protocol : manage for assets
protocol CreateAssetDelegate : AnyObject{
    func AssetCreated(_ text: String)
    func AssetFailure(_ text: String)
}
