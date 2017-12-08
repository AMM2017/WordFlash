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
    private static let path = "dictionary"
    static let sharedInstance = Dictionary()
    
    var json: JSON
    var words: [String]
    
    private init() {
        json = Dictionary.loadJson(from: Dictionary.path)
        words = Dictionary.allWords(from: json).sorted()
    }
    
    private static func loadJson(from path: String) -> JSON {
        let jsonPath = Bundle.main.path(forResource: path, ofType: "json")!
        let jsonString = try? String(contentsOfFile: jsonPath, encoding: String.Encoding.utf8)
        
        return JSON(parseJSON: jsonString!)
    }
    
    private static func allWords(from json: JSON) -> [String] {
        return json
            .dictionary!
            .keys
            .map { $0 }
    }
    
    //API
    
    var count: Int {
        return words.count
    }
    
    func word(at index: Int) -> String? {
        return words[index]
    }
    
    subscript(word: String) -> String {
        return json[word].stringValue
    }
    
    /*func decrtiption(of word: String) -> String {
        return json[word].stringValue
    }*/
}
