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
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let rightStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let gridStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var rankNumberLabel: UILabel = {
        let label = UILabel()
        
        label.font = TITLE_1_FONT
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var rankChangeLabel: UILabel = {
        let label = UILabel()
        
        label.font = BODY_FONT
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
                self.leftStackView.addArrangedSubview($0)
            }
            
            [movieTitleLabel, audienceLabel].forEach {
                self.rightStackView.addArrangedSubview($0)
            }
            
            contentView.layer.borderWidth = 0
            
            NSLayoutConstraint.activate([
                contentView.heightAnchor.constraint(equalToConstant: 80),

                leftStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
                leftStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                leftStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

                rightStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                rightStackView.leadingAnchor.constraint(equalTo: leftStackView.trailingAnchor),
                rightStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        case .icon:
            print("추가해주세요")
            [gridStackView].forEach {
                self.contentView.addSubview($0)
            }
            
            [rankNumberLabel, movieTitleLabel, rankChangeLabel, audienceLabel].forEach {
                self.gridStackView.addArrangedSubview($0)
            }
            
            contentView.layer.borderWidth = 1
            
            NSLayoutConstraint.activate([
                contentView.heightAnchor.constraint(equalToConstant: 80),
                
                gridStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                gridStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                gridStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                gridStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
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
