//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, BoxOfficeInformation>!
    private var boxOfficeData: [BoxOfficeInformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = DateFormatter.fetchYesterdayDate(dateFormatType: .navigationTitle)
        
        getBoxOfficeData {
            DispatchQueue.main.async {
                self.configureCollectionView()
                self.configureDataSource()
                self.setSnapshot()
            }
        }
    }
    
    func getBoxOfficeData(completion: @escaping() -> ()) {
        guard let url = URL(string: URLs.PREFIX + URLs.DAILY_BOX_OFFICE + DateFormatter.fetchYesterdayDate(dateFormatType: .api)) else { return }
        NetworkService().startLoad(url: url, type: BoxOffice.self) { result in
            switch result {
            case .success(let data):
                guard let boxOfficeData = data.boxOfficeResults.boxOffices else { return }
                self.boxOfficeData = boxOfficeData
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureCollectionView() {
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: self.createCollectionViewLayout())
        self.collectionView.register(BoxOfficeCell.self, forCellWithReuseIdentifier: BoxOfficeCell.reuseIdentifier)
        self.view.addSubview(self.collectionView)
    }
    
    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
}

extension ViewController {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, BoxOfficeInformation>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let data = self.boxOfficeData[indexPath.row]
            guard let movieName = data.movieName,
                  let audienceCount = data.audienceCount,
                  let audienceAccumulation = data.audienceAccumulation,
                  let rankIntensity = data.rankIntensity else { return UICollectionViewCell() }
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCell.reuseIdentifier, for: indexPath) as? BoxOfficeCell else { return UICollectionViewCell() }
            
            cell.rankNumberLabel.text = "\(indexPath.row + 1)"
            cell.movieTitleLabel.text = movieName
            cell.audienceLabel.text = "오늘 \(NumberFormatter().numberFormat(audienceCount)) / 총 \(NumberFormatter().numberFormat(audienceAccumulation))"
            
            if self.checkIfNew(data: data) {
                cell.rankChangeLabel.text = "신작"
                cell.rankChangeLabel.textColor = .red
            } else {
                cell.rankChangeLabel.attributedText = self.rankIntensityFormate(rankIntensity)
            }
            
            return cell
        })
    }
    
    func checkIfNew(data: BoxOfficeInformation) -> Bool {
        return data.rankOldAndNew == "NEW" ? true : false
    }
    
    func rankIntensityFormate(_ rankIntensity: String) -> NSAttributedString {
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
    
    func setSnapshot() {
        if dataSource == nil { return }
        
        var snapShot = NSDiffableDataSourceSnapshot<Int, BoxOfficeInformation>()
        let section = Array(0...1)
        snapShot.appendSections(section)
        snapShot.appendItems(boxOfficeData, toSection: 0)
        dataSource.apply(snapShot)
    }
}
