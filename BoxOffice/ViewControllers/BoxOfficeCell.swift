//
//  BoxOfficeCell.swift
//  BoxOffice
//
//  Created by Yejin Hong on 4/15/24.
//

import UIKit

class BoxOfficeCell: UICollectionViewCell {
    static let reuseIdentifier = "boxOfficeCell"
    
    let cellStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        
        return stackView
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .systemGray2
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let rankStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .center
        stackView.distribution = .fill
        
        return stackView
    }()
    
    let informationStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        
        return stackView
    }()
    
    let rankNumberLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = UIColor.black
        
        return label
    }()
    
    let rankChangeLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let audienceLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    func configure() {
        contentView.addSubview(cellStackView)
        [rankStackView, informationStackView, arrowImageView].forEach {
            self.cellStackView.addArrangedSubview($0)
        }
        
        [rankNumberLabel, rankChangeLabel].forEach {
            self.rankStackView.addArrangedSubview($0)
        }
        
        [titleLabel, audienceLabel].forEach {
            self.informationStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            rankStackView.widthAnchor.constraint(equalTo: cellStackView.widthAnchor, multiplier: 0.2),
            rankStackView.centerYAnchor.constraint(equalTo: cellStackView.centerYAnchor),
            rankStackView.leadingAnchor.constraint(equalTo: cellStackView.leadingAnchor),
            rankStackView.trailingAnchor.constraint(equalTo: informationStackView.leadingAnchor),
            
            informationStackView.centerYAnchor.constraint(equalTo: cellStackView.centerYAnchor),
            informationStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor),
            informationStackView.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor),
            
            arrowImageView.widthAnchor.constraint(equalTo: cellStackView.widthAnchor, multiplier: 0.15),
            arrowImageView.centerYAnchor.constraint(equalTo: cellStackView.centerYAnchor),
            arrowImageView.leadingAnchor.constraint(equalTo: informationStackView.trailingAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: cellStackView.trailingAnchor),
        ])
    }
}
