import UIKit

class AddQuoteViewController: UIViewController {
    private let storage = Storage()
    
    private lazy var quoteTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter your quote"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
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
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [quoteTextField, quoteLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        setupNavigationView()
        
        view.addSubview(verticalStackView)
        view.backgroundColor = UIColor(red: 253, green: 226, blue: 212)
        
        addConstraints()
    }
    
    private func setupNavigationView() {
        navigationItem.title = "ADD QUOTE"
        navigationController?.navigationBar.barTintColor = UIColor(red: 253, green: 226, blue: 212)
        
        let rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonPressed))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            quoteTextField.heightAnchor.constraint(equalToConstant: 50),
            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension AddQuoteViewController {
    @objc private func textFieldDidChange() {
        quoteLabel.text = quoteTextField.text
    }
    
    @objc private func saveButtonPressed() {
        if let newQuoteText = quoteLabel.text {
            storage.saveNewQuote(newQuoteText)
        }

        dismiss(animated: true)
    }
    
    @objc private func cancelButtonPressed() {
        dismiss(animated: true)
    }
}
