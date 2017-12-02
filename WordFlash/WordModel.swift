//
//  WordModel.swift
//  WordFlash
//
//  Created by Artemii Shabanov on 02.12.2017.
//  Copyright © 2017 Alexandr. All rights reserved.
//

import RealmSwift

class Word: Object {
    @objc dynamic public var word = ""
    @objc dynamic public var defenition = ""
    @objc dynamic public var isInHistory:Bool = false
    @objc dynamic public var isFavorite:Bool = false
}
