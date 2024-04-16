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
    
    lazy var calendarButton: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.title = "날짜선택"
        item.target = self
        item.action = #selector(selectCalendarDate)
        item.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = DateFormatter.fetchYesterdayDate(dateFormatType: .navigationTitle)
        self.navigationItem.rightBarButtonItem = calendarButton
        
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
        configureRefreshControl()
    }
    
    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    @objc func selectCalendarDate(sender: AnyObject) {
        self.present(CalendarViewController(), animated: true)
    }
    
    func configureRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
        
    @objc func handleRefreshControl() {
        setSnapshot()
        
        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
}

extension ViewController {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, BoxOfficeInformation>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let data = self.boxOfficeData[indexPath.row]
            guard let movieName = data.movieName,
                  let audienceCount = data.audienceCount,
                  let audienceAccumulation = data.audienceAccumulation,
                  let rankIntensity = data.rankIntensity else { return UICollectionViewListCell() }
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCell.reuseIdentifier, for: indexPath) as? BoxOfficeCell else { return UICollectionViewListCell() }
            
            cell.rankNumberLabel.text = "\(indexPath.row + 1)"
            cell.movieTitleLabel.text = movieName
            cell.audienceLabel.text = "오늘 \(NumberFormatter().numberFormat(audienceCount)) / 총 \(NumberFormatter().numberFormat(audienceAccumulation))"
            
            if self.checkIfNew(data: data) {
                cell.rankChangeLabel.text = "신작"
                cell.rankChangeLabel.textColor = .red
            } else {
                cell.rankChangeLabel.attributedText = self.rankIntensityFormate(rankIntensity)
            }
            
            cell.accessories = [.disclosureIndicator(displayed: .always)]
            
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
