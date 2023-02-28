import UIKit

class MyQuotesTableViewController: UITableViewController {
    private let myQuotesViewModel = MyQuotesViewModel()
    private let cellId = "MyQuoteCellId"
    
    private lazy var myQuotes: [Quote] = {
        return myQuotesViewModel.myQuotes
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(red: 253, green: 226, blue: 212)
        
        navigationItem.title = "MY QUOTES"
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
        return myQuotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BaseQuoteTableViewCell
        let myQuote = myQuotes[indexPath.row]
        cell.configure(quoteMessage: myQuote.message)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        let quoteToRemove = myQuotes[indexPath.row]
        myQuotes.remove(at: indexPath.row)
        myQuotesViewModel.removeQuote(quoteToRemove)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
