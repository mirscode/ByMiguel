import UIKit

class BookmarkQuotesTableViewController: UITableViewController {
    private let quotesViewModel = QuotesViewModel()
    private let cellId = "BookmarkQuoteCellId"
    var bookmarkedQuotes = [Quote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(red: 253, green: 226, blue: 212)
        
        navigationItem.title = "BOOKMARKS"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor(red: 253, green: 226, blue: 212)
        
        tableView.register(BookmarkQuoteCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .singleLine
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkedQuotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BookmarkQuoteCell
        let bookmarkQuote = bookmarkedQuotes[indexPath.row]
        cell.configure(quoteMessage: bookmarkQuote.message)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let quoteToRemove = bookmarkedQuotes[indexPath.row]
        bookmarkedQuotes.remove(at: indexPath.row)
        quotesViewModel.unbookmarkQuote(quoteToRemove)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
