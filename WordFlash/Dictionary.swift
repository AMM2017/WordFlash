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
    static let sharedInstance = Dictionary()
    private static let path = "dictionary"
    
    var json: JSON
    var arrayOfKeys: [String]?
    
    private init() {
        json = Dictionary.loadJson(from: Dictionary.path)
        arrayOfKeys = Dictionary.getArrayofKeys(from: json).sorted()
    }
    
    private static func loadJson(from path: String) -> JSON {
        let path = Bundle.main.path(forResource: path, ofType: "json")!
        let jsonString = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
        
        return JSON(parseJSON: jsonString!)
    }
    
    private static func getArrayofKeys(from json: JSON) -> Array<String> {
        var arrayOfKeys: Array<String> = []
        
        for (key, _) in json {
            arrayOfKeys.append(key)
        }
        
        return arrayOfKeys
    }
    
    //API
    
    var count: Int? {
        get {
            return arrayOfKeys?.count
        }
    }
    
    func getWord(at index: Int) -> String? {
        return arrayOfKeys?[index]
    }
    
    func getDecrtiption(at word: String) -> String {
        return json[word].stringValue
    }
    
    
    
    
    
    
}
