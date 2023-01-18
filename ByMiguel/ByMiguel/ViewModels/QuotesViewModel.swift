//
//  Quotes.swift
//  ByMiguel
//
//  Created by Mir Ahmed on 9/29/22.
//

import Foundation

class QuotesViewModel {
    private let currentQuoteIndexKey = "currentQuoteIndex"
    private var quotes = [Quote]()
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
    
    private func saveCurrentQuoteIndexKey() {
        DispatchQueue.main.async {
            UserDefaults.standard.set(self.currentQuoteIndex, forKey: self.currentQuoteIndexKey)
        }
    }
}
