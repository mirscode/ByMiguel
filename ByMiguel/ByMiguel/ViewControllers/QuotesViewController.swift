//
//  ViewController.swift
//  ByMiguel
//
//  Created by Mir Ahmed on 9/26/22.
//

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
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [previousButton, nextButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(quoteLabel)
        view.addSubview(buttonStackView)
        view.backgroundColor = UIColor(red: 253, green: 226, blue: 212)
        
        let quote = quotesViewModel.getCurrentQuote()
        quoteLabel.text = quote.message
        addConstraints()
    }
    
    private func addConstraints() {
        quoteLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        quoteLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 27).isActive = true
        quoteLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -72).isActive = true
        quoteLabel.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor).isActive = true
        
        previousButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        previousButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        nextButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
    }
    
    @objc private func showNextQuote() {
        let quote = quotesViewModel.getNextQuote()
        quoteLabel.text = quote.message
    }
    
    @objc private func showPreviousQuote() {
        let quote = quotesViewModel.getPreviousQuote()
        quoteLabel.text = quote.message
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: alpha)
    }
}
