//
//  ViewController.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, BoxOfficeInformation>!
    private var boxOfficeData: [BoxOfficeInformation] = []
    private var selectedDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date() - 86400)
    
    lazy var calendarButton: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.title = "날짜선택"
        item.target = self
        item.action = #selector(selectCalendarDate)
        item.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        return item
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center = view.center
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        activityIndicator.color = .black
        activityIndicator.backgroundColor = .white
        
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = calendarButton
        configureCollectionView()
        configureDataSource()
        configureUI()
    }
    
    func configureUI() {
        getBoxOfficeData {
            DispatchQueue.main.async {
                self.updateNavigationBar()
                self.setSnapshot()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func updateNavigationBar() {
        let dateComponents = selectedDateComponents
        let date = DateFormatter.fetchYesterdayDate(dateFormatType: .navigationTitle, dateComponents: dateComponents)
        navigationItem.title = date
    }
    
    func getBoxOfficeData(completion: @escaping() -> ()) {
        guard let url = URL(string: URLs.PREFIX + URLs.DAILY_BOX_OFFICE + DateFormatter.fetchYesterdayDate(dateFormatType: .api, dateComponents: self.selectedDateComponents)) else { return }
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewLayout())
        collectionView.register(BoxOfficeCell.self, forCellWithReuseIdentifier: BoxOfficeCell.reuseIdentifier)
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        configureRefreshControl()
    }
    
    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    @objc func selectCalendarDate(sender: AnyObject) {
        let vc = CalendarViewController()
        vc.delegate = self
        vc.selectedDateComponents = selectedDateComponents
        
        present(vc, animated: true)
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

extension ViewController: SendDataDelegate {
    func updateDate(dateComponents: DateComponents) {
        activityIndicator.startAnimating()
        selectedDateComponents = dateComponents
        configureUI()
    }
}
