//
//  BoxOfficeCell.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/15/24.
//

import UIKit

class BoxOfficeCell: UICollectionViewListCell {
    static let reuseIdentifier = "boxOfficeCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("BoxOfficeCell init Error")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        rankNumberLabel.text = ""
        rankChangeLabel.text = ""
        movieTitleLabel.text = ""
        audienceLabel.text = ""
        
        rankChangeLabel.textColor = .black
    }
    
    private let leftStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private let rightStackView: UIStackView = {
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
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
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
    
    override func updateConstraints() {
      super.updateConstraints()

      separatorLayoutGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
    }
    
    private func configure() {
        [leftStackView, rightStackView].forEach {
            self.contentView.addSubview($0)
        }
        
        [rankNumberLabel, rankChangeLabel].forEach {
            self.leftStackView.addArrangedSubview($0)
        }
        
        [movieTitleLabel, audienceLabel].forEach {
            self.rightStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 80),

            leftStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            leftStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            leftStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

            rightStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightStackView.leadingAnchor.constraint(equalTo: leftStackView.trailingAnchor),
            rightStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

extension BoxOfficeCell {
    func updateComponents(data: BoxOfficeInformation) {
        guard let movieRank = data.rank,
              let movieName = data.movieName,
              let audienceCount = data.audienceCount,
              let audienceAccumulation = data.audienceAccumulation,
              let rankIntensity = data.rankIntensity else { return }
        
        rankNumberLabel.text = movieRank
        movieTitleLabel.text = movieName
        audienceLabel.text = "오늘 \(NumberFormatter.formatNumber(audienceCount)) / 총 \(NumberFormatter.formatNumber(audienceAccumulation))"
        
        if self.checkIfNew(data: data) {
            rankChangeLabel.text = "신작"
            rankChangeLabel.textColor = .red
        } else {
            rankChangeLabel.attributedText = rankIntensityFormate(rankIntensity)
        }
        
        accessories = [.disclosureIndicator(displayed: .always)]
    }
    
    private func checkIfNew(data: BoxOfficeInformation) -> Bool {
        return data.rankOldAndNew == "NEW" ? true : false
    }
    
    private func rankIntensityFormate(_ rankIntensity: String) -> NSAttributedString {
        let number = Int(rankIntensity) ?? 0
        
        if number > 0 {
            return UILabel().asColor(color: .red, fullText: "▲\(abs(number))", targetString: "▲")
        } else if number < 0 {
            return UILabel().asColor(color: .systemBlue,
                                     fullText: "▼\(abs(number))", targetString: "▼")
        } else {
            return UILabel().asColor(color: .black, fullText: "-", targetString: "")
        }
    }
}
