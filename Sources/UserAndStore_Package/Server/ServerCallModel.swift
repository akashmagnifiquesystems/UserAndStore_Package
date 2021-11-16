//
//  File.swift
//  
//
//  Created by Aakash Patel on 10/11/21.
//

import Foundation

import UIKit
import Alamofire

public struct ServerCallModel {

    static let shared = ServerCallModel()

    public init() {
    }
    
    public func postUpdateUserData(params: Parameters, apiname: String, completion : @escaping (NSDictionary) -> Void) {
        let parameters: Parameters = params
        
        let url = baseUrl + apiname
        print("URL ======================\n", url)
        print("Parameters ===============\n", parameters)
        
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        var convertedJsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        convertedJsonString = convertedJsonString.replacingOccurrences(of: "\n", with: " ", options: .literal, range: nil)
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        let data = (convertedJsonString.data(using: .utf8))! as Data
        
        request.httpBody = data
        
        AF.request(request)
            .responseJSON { (response) in
                print("Response ======================\n",response)
                if let response = response.value {
                    completion(response as! NSDictionary)
                } else {
                    print(response.error.debugDescription)
                }
            }
    }
}
