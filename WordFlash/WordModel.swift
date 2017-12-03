import RealmSwift

class Word: Object {
    @objc dynamic public var word = ""
    @objc dynamic public var defenition = ""
    @objc dynamic public var isInHistory:Bool = false
    @objc dynamic public var isFavorite:Bool = false
    
    override static func primaryKey() -> String? {
        return "word"
    }
}
