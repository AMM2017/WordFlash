//
//  Dictionary.swift
//  WordFlash
//
//  Created by Alexandr on 01/12/2017.
//  Copyright © 2017 Alexandr. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Foo {
    struct Boo {
        
    }
}

let boo = Foo.Boo()

class Dictionary {
    static let sharedInstance = Dictionary()
    private static let path = "dictionary"
    
    var json: JSON
    var arrayOfKeys: [String]?
    
    private init() {
        // dispatch once
        json = Dictionary.loadJson(from: Dictionary.path)
        arrayOfKeys = Dictionary.getArrayofKeys(from: json).sorted()
        
    }
    
    private static func loadJson(from path: String) -> JSON {
        let path = Bundle.main.path(forResource: path, ofType: "json")!
        let jsonString = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
        
        return JSON(parseJSON: jsonString!)
    }
    
    private static func getArrayofKeys(from json: JSON) -> [String] {
        return json
            .dictionary!
            .keys
            .map { $0 }
    }
    
    //API
    
    var count: Int {
            return arrayOfKeys?.count ?? 0
    }
    
    func word(at index: Int) -> String? {
        return arrayOfKeys?[index]
    }
    
    func decrtiption(at word: String) -> String {
        return json[word].stringValue
    }
    
}
