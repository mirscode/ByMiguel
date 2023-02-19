import Foundation

class QuotesViewModel {
    private let storage = Storage()

    var quotes = [Quote]()
    var bookmarkedQuotes = [Quote]()
    
    private var bookmarkedQuotesIds = Set<Int>()
    private var currentQuoteIndex: Int
    
    init() {
        let fileName = "quotes"
        let data = readJsonFile(forFileName: fileName)
        
        if let data = data, let quotesList = parse(data: data) {
            self.quotes = quotesList.quotes
        }
        
        currentQuoteIndex = storage.loadCurrentQuoteIndex()
        bookmarkedQuotesIds = storage.load()
        bookmarkedQuotes = quotes.filter { bookmarkedQuotesIds.contains($0.identifier) }
    }
    
    func getCurrentQuote() -> Quote {
        return quotes[currentQuoteIndex]
    }
    
    func getNextQuote() -> Quote {
        currentQuoteIndex += 1

        if currentQuoteIndex >= quotes.count {
            currentQuoteIndex = 0
        }
        
        storage.saveCurrentQuoteIndex(currentQuoteIndex)
        return quotes[currentQuoteIndex]
    }
    
    func getPreviousQuote() -> Quote {
        currentQuoteIndex -= 1

        if currentQuoteIndex < 0 {
            currentQuoteIndex = quotes.count - 1
        }
        
        storage.saveCurrentQuoteIndex(currentQuoteIndex)
        return quotes[currentQuoteIndex]
    }
    
    func bookmarkQuote(_ quote: Quote) {
        guard !bookmarkedQuotesIds.contains(quote.identifier) else { return }
        
        bookmarkedQuotesIds.insert(quote.identifier)
        bookmarkedQuotes.append(quote)
        storage.save(quoteIds: bookmarkedQuotesIds)
    }
}
