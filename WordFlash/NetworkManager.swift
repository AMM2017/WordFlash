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
    private let getTokenPath = "/get-token/"
    
    func token(from user: User) -> String? {
        let parameters: Parameters = [
            "username": user.username ?? "",
            "password": user.password ?? ""
        ]
        
        print(parameters)
        
        let url = "https://wordflash.herokuapp.com/get-token/"
        var json: JSON?
        
        Alamofire.request(url, method:.post, parameters:parameters).responseJSON { response in
            switch response.result {
            case .success:
                print(JSON(response.data)["token"])
                //debugPrint(response)
            case .failure(let error):
                print(error)
            }
            
        }
        
        return nil
    }
}

struct User {
    var username: String?
    var password: String?
    var historyWords: [String] = []
    var favoriteWords: [String] = []
}
