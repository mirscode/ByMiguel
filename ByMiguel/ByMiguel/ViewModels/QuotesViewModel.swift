import Foundation

class QuotesViewModel {
    private let currentQuoteIndexKey = "currentQuoteIndex"
    // change back to private
    var quotes = [Quote]()
    private var bookmarkQuotes = [Quote]()
    private var currentQuoteIndex: Int
    
    init() {
        let fileName = "quotes"
        let data = readJsonFile(forFileName: fileName)
        
        if let data = data, let quotesList = parse(data: data) {
            self.quotes = quotesList.quotes
        }

        currentQuoteIndex = UserDefaults.standard.integer(forKey: currentQuoteIndexKey)
    }
    
    func getCurrentQuote() -> Quote {
        return quotes[currentQuoteIndex]
    }
    
    func getNextQuote() -> Quote {
        currentQuoteIndex += 1

        if currentQuoteIndex >= quotes.count {
            currentQuoteIndex = 0
        }
        
        saveCurrentQuoteIndexKey()
        return quotes[currentQuoteIndex]
    }
    
    func getPreviousQuote() -> Quote {
        currentQuoteIndex -= 1

        if currentQuoteIndex < 0 {
            currentQuoteIndex = quotes.count - 1
        }
        
        saveCurrentQuoteIndexKey()
        return quotes[currentQuoteIndex]
    }
    
    func bookmarkQuote(_ quote: Quote) {
        bookmarkQuotes.append(quote)
    }
    
    private func saveCurrentQuoteIndexKey() {
        DispatchQueue.main.async {
            UserDefaults.standard.set(self.currentQuoteIndex, forKey: self.currentQuoteIndexKey)
        }
    }
}
