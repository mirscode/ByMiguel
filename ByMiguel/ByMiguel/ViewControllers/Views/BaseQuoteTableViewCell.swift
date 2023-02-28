import UIKit

class BaseQuoteTableViewCell: UITableViewCell {
    private lazy var cellContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    func configure(quoteMessage: String) {
        quoteLabel.text = quoteMessage
    }
    
    private func setupViews() {
        cellContainer.addSubview(quoteLabel)
        addSubview(cellContainer)
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            cellContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            cellContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            cellContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cellContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            quoteLabel.leadingAnchor.constraint(equalTo: cellContainer.leadingAnchor, constant: 16),
            quoteLabel.trailingAnchor.constraint(equalTo: cellContainer.trailingAnchor, constant: -16),
            quoteLabel.topAnchor.constraint(equalTo: cellContainer.topAnchor, constant: 16),
            quoteLabel.bottomAnchor.constraint(equalTo: cellContainer.bottomAnchor, constant: -16)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(red: 253, green: 226, blue: 212)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
