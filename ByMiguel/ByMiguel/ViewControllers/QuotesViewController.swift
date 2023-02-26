import UIKit

class QuotesViewController: UIViewController {
    private let quotesViewModel = QuotesViewModel()
    
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
        button.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(showPreviousQuote), for: .touchUpInside)
        
        let backChevronImage = UIImage(systemName: "chevron.backward")
        button.setImage(backChevronImage, for: .normal)
        button.imageView?.tintColor = .black
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(showNextQuote), for: .touchUpInside)
        
        let forwardChevronImage = UIImage(systemName: "chevron.forward")
        button.setImage(forwardChevronImage, for: .normal)
        button.imageView?.tintColor = .black
        return button
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handleBookmarkButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [previousButton, nextButton, bookmarkButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var menuItems: [UIAction] = {
        let addQuote = UIAction(title: "Add Quote", handler: { (_) in
            self.presentAddQuoteViewController()
        })
        
        let showBookmarks = UIAction(title: "Show Bookmarks", handler: { (_) in
            self.presentBookmarkQuotesTableViewController()
        })
        
        return [addQuote, showBookmarks]
    }()
    
    private lazy var menu = UIMenu(children: menuItems)

    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
        
        let ellipsisImage = UIImage(systemName: "ellipsis.circle")
        button.setImage(ellipsisImage, for: .normal)
        button.imageView?.tintColor = .black
        button.imageView?.backgroundColor = UIColor(red: 253, green: 226, blue: 212)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(menuButton)
        view.addSubview(quoteLabel)
        view.addSubview(buttonStackView)
        view.backgroundColor = UIColor(red: 253, green: 226, blue: 212)
        
        let quote = quotesViewModel.getCurrentQuote()
        quoteLabel.text = quote.message
        refreshBookmarkButton()
        
        addConstraints()
    }
    
    private func refreshBookmarkButton() {
        let state = quotesViewModel.getBookmarkState()
        let imageName = state == .normal ? "bookmark" : "bookmark.fill"
        let bookmarkImage = UIImage(systemName: imageName)
        bookmarkButton.setImage(bookmarkImage, for: .normal)
        bookmarkButton.imageView?.tintColor = .black
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
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

extension QuotesViewController {
    @objc private func showNextQuote() {
        let quote = quotesViewModel.getNextQuote()
        quoteLabel.text = quote.message
        refreshBookmarkButton()
    }
    
    @objc private func showPreviousQuote() {
        let quote = quotesViewModel.getPreviousQuote()
        quoteLabel.text = quote.message
        refreshBookmarkButton()
    }
    
    @objc private func handleBookmarkButtonPressed() {
        let quote = quotesViewModel.getCurrentQuote()
        let state = quotesViewModel.getBookmarkState()
        
        if state == .normal {
            quotesViewModel.bookmarkQuote(quote)
        } else if state == .selected {
            quotesViewModel.unbookmarkQuote(quote)
        }
        
        refreshBookmarkButton()
    }
}

extension QuotesViewController {
    private func presentAddQuoteViewController() {
        let addQuoteViewController = AddQuoteViewController()
        let navigationController = UINavigationController(rootViewController: addQuoteViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    private func presentBookmarkQuotesTableViewController() {
        let bookmarkQuotesTableViewController = BookmarkQuotesTableViewController()
        bookmarkQuotesTableViewController.quotesViewModel = quotesViewModel
        let navigationController = UINavigationController(rootViewController: bookmarkQuotesTableViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}
