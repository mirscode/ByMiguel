import Foundation

class Storage {
    private let storage = UserDefaults.standard
    private let bookmarksKey = "bookmarkedQuotes"
    private let currentQuoteIndexKey = "currentQuoteIndex"
    private let myQuotesKey = "myQuotes"
    
    func save(quoteIds: Set<Int>) {
        let quotesArray = Array(quoteIds)
        storage.set(quotesArray, forKey: bookmarksKey)
    }
    
    func load() -> Set<Int> {
        let quotesArray = storage.array(forKey: bookmarksKey) as? [Int] ?? [Int]()
        return Set(quotesArray)
    }
    
    func saveCurrentQuoteIndex(_ quoteIndexKey: Int) {
        storage.set(quoteIndexKey, forKey: currentQuoteIndexKey)
    }
    
    func loadCurrentQuoteIndex() -> Int {
        return storage.integer(forKey: currentQuoteIndexKey)
    }
    
    func loadMyQuotes() -> [String] {
        let myQuotesArray = storage.array(forKey: myQuotesKey) as? [String] ?? [String]()
        return myQuotesArray
    }
    
    func saveMyQuotes(_ myQuotes: [String]) {
        storage.set(myQuotes, forKey: myQuotesKey)
    }
}
