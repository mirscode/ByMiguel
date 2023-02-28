import Foundation
import UIKit

class MyQuotesViewModel {
    private let storage = Storage()
    private var myQuotesStringArray: [String]
    var myQuotes: [Quote]
    
    init() {
        myQuotesStringArray = storage.loadMyQuotes()
        myQuotes = myQuotesStringArray.enumerated().map({ Quote(identifier: $0, message: $1) })
    }
    
    func addQuote(quoteText: String) {
        let newQuote = Quote(identifier: myQuotesStringArray.count - 1, message: quoteText)
        myQuotes.append(newQuote)
        
        myQuotesStringArray.append(quoteText)
        storage.saveMyQuotes(myQuotesStringArray)
    }
    
    func removeQuote(_ quote: Quote) {
        myQuotesStringArray = myQuotesStringArray.filter { $0 != quote.message }
        myQuotes = myQuotes.filter { $0.identifier != quote.identifier }
        storage.saveMyQuotes(myQuotesStringArray)
    }
}

/**
 addQuote
 removeQuote
 getAllmyQuotes
 */
