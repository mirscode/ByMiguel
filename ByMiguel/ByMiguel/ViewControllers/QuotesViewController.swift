import UIKit

class QuotesViewController: UIViewController {
    
    private var quotesViewModel = QuotesViewModel()
    
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .label
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        return label
    }()
    
    private lazy var previousButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        button.setTitle("PREV", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(showPreviousQuote), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(showNextQuote), for: .touchUpInside)
        return button
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        button.setTitle("FAV", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(bookmarkQuote), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [previousButton, nextButton, bookmarkButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @objc private func showNextQuote() {
        let quote = quotesViewModel.getNextQuote()
        quoteLabel.text = quote.message
    }
    
    @objc private func showPreviousQuote() {
        let quote = quotesViewModel.getPreviousQuote()
        quoteLabel.text = quote.message
    }
    
    @objc private func bookmarkQuote() {
        let quote = quotesViewModel.getCurrentQuote()
        quotesViewModel.bookmarkQuote(quote)
        print(quote.message)
        
        let bookmarkQuotesTableViewController = BookmarkQuotesTableViewController()
        bookmarkQuotesTableViewController.bookmarkQuotes = quotesViewModel.bookmarkedQuotes
        let navigationController = UINavigationController(rootViewController: bookmarkQuotesTableViewController)
        present(navigationController, animated: true)
    }
    
    private func setupViews() {
        view.addSubview(quoteLabel)
        view.addSubview(buttonStackView)
        view.backgroundColor = UIColor(red: 253, green: 226, blue: 212)
        
        let quote = quotesViewModel.getCurrentQuote()
        quoteLabel.text = quote.message
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            quoteLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            quoteLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 27),
            quoteLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -72),
            quoteLabel.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor),
            previousButton.heightAnchor.constraint(equalToConstant: 65),
            previousButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 65),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 65),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 100),
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25)
        ])
    }
}
