//
//  Dictionary.swift
//  WordFlash
//
//  Created by Alexandr on 01/12/2017.
//  Copyright © 2017 Alexandr. All rights reserved.
//

import Foundation
import SwiftyJSON

class Dictionary {
    static func load(from path: String) -> JSON {
        let path = Bundle.main.path(forResource: path, ofType: "json")!
        let jsonString = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
        
        return JSON(parseJSON: jsonString!)
    }
    
    static func getArrayofKeys(from json: JSON) -> Array<String> {
        var arrayOfKeys: Array<String> = []
        
        for (key, value) in json {
            arrayOfKeys.append(key)
        }
        
        return arrayOfKeys
    }
}
