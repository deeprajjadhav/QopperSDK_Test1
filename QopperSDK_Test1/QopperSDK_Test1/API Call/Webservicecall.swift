//
//  Webservicecall.swift
//  QAssets
//
//  Created by Mac on 05/09/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

/// Webservice call for GET
///
/// - Parameters:
///   - url: url
///   - failure: failure
///   - completion: completion
func getResponse(_ url:String,failure:@escaping (_ _error:NSDictionary)->Void,completion:@escaping (_ _response:NSDictionary)->Void) ->Void {
    let semaphore = DispatchSemaphore(value: 0)
    do {
        
        let escapedUrlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let req_url = URL(string: escapedUrlString!)
        let request = NSMutableURLRequest(url: req_url!,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(ACCESS_TOKEN)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            DispatchQueue.main.async(execute: {
                if error != nil{
                    let aDict = ["status":"false","developer_message":error?.localizedDescription,"code":""]
                    failure(aDict as NSDictionary)
                }
            })
            do {
                if data != nil {
                    let result = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    let total = result.allKeys.count
                    if total > 0{
                        completion(result)
                    }else{
                        let aDict = ["status":"false","developer_message":error?.localizedDescription,"code":""]
                        completion(aDict as NSDictionary)
                    }
                }
                else{
                    let aDict = ["status":"false","developer_message":error?.localizedDescription,"code":""]
                    completion(aDict as NSDictionary)
                }
            } catch {
                let aDict = ["status":"false","developer_message":error.localizedDescription,"code":""]
                failure(aDict as NSDictionary)
            }
            semaphore.signal()
        })
        task.resume()
//        semaphore.wait(timeout: DispatchTime.distantFuture)
    }
}

/// Webservice call for POST
///
/// - Parameters:
///   - url: url
///   - strBody: strBody
///   - failure: failure
///   - completion: completion
func postResponse(_ url:String, strBody:Any,failure:@escaping (_ _error:NSDictionary)->Void,completion:@escaping (_ _response:NSDictionary)->Void) ->Void {
    let semaphore = DispatchSemaphore(value: 10)
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: strBody, options:.prettyPrinted)
        let request = NSMutableURLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(ACCESS_TOKEN)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if error != nil{
                let aDict = ["status":"false","developer_message":error?.localizedDescription,"code":""]
                failure(aDict as NSDictionary)
            }
            else{
                do {
                    let result = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    completion(result)
                } catch {
                    let aDict = ["status":"false","developer_message":error.localizedDescription,"code":""]
                    failure(aDict as NSDictionary)
                }
            }
            semaphore.signal()
        })
        task.resume()
    }catch {
        let aDict = ["status":"false","developer_message":error.localizedDescription,"code":""]
        failure(aDict as NSDictionary)
    }
}

func patchResponse(_ url:String, strBody:Any,failure:@escaping (_ _error:NSDictionary)->Void,completion:@escaping (_ _response:NSDictionary)->Void) ->Void {
    let semaphore = DispatchSemaphore(value: 10)
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: strBody, options:.prettyPrinted)
        let request = NSMutableURLRequest(url: URL(string: url)!)
        request.httpMethod = "PATCH"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(ACCESS_TOKEN)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if error != nil{
                let aDict = ["status":"false","developer_message":error?.localizedDescription,"code":""]
                failure(aDict as NSDictionary)
            }
            else{
                do {
                    let result = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    completion(result)
                } catch {
                    let aDict = ["status":"false","developer_message":error.localizedDescription,"code":""]
                    failure(aDict as NSDictionary)
                }
            }
            semaphore.signal()
        })
        task.resume()
    }catch {
        let aDict = ["status":"false","developer_message":error.localizedDescription,"code":""]
        failure(aDict as NSDictionary)
    }
}
