import UIKit

protocol BookmarkQuotesTableViewControllerProtocol {
    var quotesViewModel: QuotesViewModel? { get set }
}

class BookmarkQuotesTableViewController: UITableViewController, BookmarkQuotesTableViewControllerProtocol {
    weak var quotesViewModel: QuotesViewModel?
    
    private let cellId = "BookmarkQuoteCellId"
    
    private lazy var bookmarkedQuotes: [Quote] = {
        if let bookmarkedQuotes = quotesViewModel?.bookmarkedQuotes {
            return bookmarkedQuotes
        }
        
        return [Quote]()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(red: 253, green: 226, blue: 212)
        
        navigationItem.title = "BOOKMARKS"
        navigationController?.navigationBar.barTintColor = UIColor(red: 253, green: 226, blue: 212)
        
        let rightBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissController))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        tableView.register(BaseQuoteTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .singleLine
    }
    
    @objc private func dismissController() {
        dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkedQuotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BaseQuoteTableViewCell
        let bookmarkQuote = bookmarkedQuotes[indexPath.row]
        cell.configure(quoteMessage: bookmarkQuote.message)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let quoteToRemove = bookmarkedQuotes[indexPath.row]
        bookmarkedQuotes.remove(at: indexPath.row)
        quotesViewModel?.unbookmarkQuote(quoteToRemove)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
