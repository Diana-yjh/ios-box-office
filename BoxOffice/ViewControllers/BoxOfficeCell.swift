//
//  BoxOfficeCell.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/15/24.
//

import UIKit

class BoxOfficeCell: UICollectionViewListCell {
    static let IDENTIFIER = "boxOfficeCell"
    
    final let TITLE_1_FONT: UIFont = FontConstants.TITLE1
    final let TITLE_3_BOLD_FONT: UIFont = FontConstants.TITLE3_BOLD
    final let BODY_FONT: UIFont = FontConstants.BODY
    
    var cellMode: CellMode = .list
    
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
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var rankNumberLabel: UILabel = {
        let label = UILabel()
        
        label.font = TITLE_1_FONT
        label.textAlignment = .center
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var rankChangeLabel: UILabel = {
        let label = UILabel()
        
        label.font = BODY_FONT
        label.textAlignment = .center
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    private let rightStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = TITLE_3_BOLD_FONT
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var audienceLabel: UILabel = {
        let label = UILabel()
        
        label.font = BODY_FONT
        label.numberOfLines = 0
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let gridStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override func updateConstraints() {
      super.updateConstraints()

      separatorLayoutGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
    }
    
    func configure() {
        switch cellMode {
        case .list:
            [leftStackView, rightStackView].forEach {
                self.contentView.addSubview($0)
            }
            
            [rankNumberLabel, rankChangeLabel].forEach {
                self.leftStackView.addSubview($0)
            }
            
            [movieTitleLabel, audienceLabel].forEach {
                self.rightStackView.addSubview($0)
            }
            
            contentView.layer.borderWidth = 0
            
            NSLayoutConstraint.activate([
                leftStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
                leftStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                leftStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                
                rankNumberLabel.topAnchor.constraint(equalTo: leftStackView.topAnchor),
                rankNumberLabel.leadingAnchor.constraint(equalTo: leftStackView.leadingAnchor),
                rankNumberLabel.bottomAnchor.constraint(equalTo: rankChangeLabel.topAnchor),
                rankNumberLabel.trailingAnchor.constraint(equalTo: leftStackView.trailingAnchor),
                
                rankChangeLabel.topAnchor.constraint(equalTo: rankNumberLabel.bottomAnchor),
                rankChangeLabel.leadingAnchor.constraint(equalTo: leftStackView.leadingAnchor),
                rankChangeLabel.trailingAnchor.constraint(equalTo: leftStackView.trailingAnchor),
                rankChangeLabel.bottomAnchor.constraint(equalTo: leftStackView.bottomAnchor),
                
                rightStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                rightStackView.leadingAnchor.constraint(equalTo: leftStackView.trailingAnchor),
                rightStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
                rightStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                
                movieTitleLabel.topAnchor.constraint(equalTo: rightStackView.topAnchor),
                movieTitleLabel.leadingAnchor.constraint(equalTo: rightStackView.leadingAnchor),
                movieTitleLabel.bottomAnchor.constraint(equalTo: audienceLabel.topAnchor),
                movieTitleLabel.trailingAnchor.constraint(equalTo: rightStackView.trailingAnchor),
                
                audienceLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor),
                audienceLabel.leadingAnchor.constraint(equalTo: rightStackView.leadingAnchor),
                audienceLabel.bottomAnchor.constraint(equalTo: rightStackView.bottomAnchor),
                audienceLabel.trailingAnchor.constraint(equalTo: rightStackView.trailingAnchor)
            ])
        case .icon:
            [leftStackView, rightStackView].forEach {
                $0.removeFromSuperview()
            }
            
            [gridStackView].forEach {
                self.contentView.addSubview($0)
            }
            
            [rankNumberLabel, movieTitleLabel, rankChangeLabel, audienceLabel].forEach {
                self.gridStackView.addArrangedSubview($0)
            }
            
            contentView.layer.borderWidth = 1
            
            NSLayoutConstraint.activate([
                gridStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
                gridStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                gridStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                gridStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                
            ])
        }
    }
}

extension BoxOfficeCell {
    func updateComponents(data: BoxOfficeInformationDTO) {
        rankNumberLabel.text = data.rank
        movieTitleLabel.text = data.movieName
        audienceLabel.text = "오늘 \(NumberFormatter.formatNumber(data.audienceCount)) / 총 \(NumberFormatter.formatNumber(data.audienceAccumulation))"
        
        if data.checkIfNew() {
            rankChangeLabel.text = "신작"
            rankChangeLabel.textColor = .red
        } else {
            rankChangeLabel.attributedText = data.rankIntensityFormate()
        }
        
        if cellMode == .list {
            accessories = [.disclosureIndicator(displayed: .always)]
        } else {
            accessories.removeAll()
        }
    }
}
