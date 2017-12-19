//
//  NetworkManager.swift
//  WordFlash
//
//  Created by xcode on 19.12.2017.
//  Copyright © 2017 Alexandr. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    private let urlString = "https://wordflash.herokuapp.com"
    
    func token(for user: User) -> User {
        Alamofire.request(urlString).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
        return user
    }
}

struct User {
    var username: String?
    var password: String?
    var historyWords: [String]
    var favoriteWords: [String]
}
