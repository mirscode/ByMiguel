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
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(red: 253, green: 226, blue: 212)
        
        navigationItem.title = "BOOKMARKS"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor(red: 253, green: 226, blue: 212)
        navigationController?.navigationBar.addSubview(dismissButton)
        
        tableView.register(BookmarkQuoteCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .singleLine
        
        addConstraints()
    }
    
    private func addConstraints() {
        var constraints: [NSLayoutConstraint] = [
            dismissButton.widthAnchor.constraint(equalToConstant: 50),
            dismissButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        if let navigationBar = navigationController?.navigationBar {
            constraints.append(dismissButton.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -15))
            constraints.append(dismissButton.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 15))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func dismissController() {
        dismiss(animated: true)
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
        quotesViewModel?.unbookmarkQuote(quoteToRemove)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
