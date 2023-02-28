import Foundation

class Storage {
    private let storage = UserDefaults.standard
    private let bookmarksKey = "bookmarkedQuotes"
    private let currentQuoteIndexKey = "currentQuoteIndex"
    private let myQuotesKey = "myQuotes"
    private var myQuotesArray = [String]()
    
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
    
    func getAllOwnQuotes() {
        print("hello")
    }
    
    func saveNewQuote(_ newQuoteText: String) {
        myQuotesArray.append(newQuoteText)
        storage.set(myQuotesArray, forKey: myQuotesKey)
    }
}
