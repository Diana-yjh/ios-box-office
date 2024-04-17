//
//  ViewController.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 13/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, BoxOfficeInformation>!
    private var boxOfficeData: [BoxOfficeInformation] = []
    private var selectedDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date.yesterday)
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: self.createCollectionViewLayout())
        return collectionView
    }()
    
    private lazy var calendarButton: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.title = "날짜선택"
        item.target = self
        item.action = #selector(selectCalendarDate)
        item.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        return item
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
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
    
    private func configureUI() {
        getBoxOfficeData {
            DispatchQueue.main.async {
                self.updateNavigationBar()
                self.setSnapshot()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func updateNavigationBar() {
        let dateComponents = selectedDateComponents
        let date = DateFormatter.fetchYesterdayDate(dateFormatType: .navigationTitle, dateComponents: dateComponents)
        navigationItem.title = date
    }
    
    private func getBoxOfficeData(completion: @escaping() -> ()) {
        guard let url = URL(string: URLs.PREFIX + URLs.DAILY_BOX_OFFICE + DateFormatter.fetchYesterdayDate(dateFormatType: .api, dateComponents: self.selectedDateComponents)) else { return }
        NetworkService().startLoad(url: url, type: BoxOffice.self) { result in
            switch result {
            case .success(let data):
                guard let boxOfficeData = data.boxOfficeResults.boxOffices else { return }
                self.boxOfficeData = boxOfficeData
                completion()
            case .failure(let error):
                self.errorAlert()
            }
        }
    }
    
    private func configureCollectionView() {
        collectionView.register(BoxOfficeCell.self, forCellWithReuseIdentifier: BoxOfficeCell.reuseIdentifier)
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        configureRefreshControl()
    }
    
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    @objc private func selectCalendarDate(sender: AnyObject) {
        let vc = CalendarViewController()
        vc.delegate = self
        vc.selectedDateComponents = selectedDateComponents
        
        present(vc, animated: true)
    }
    
    private func configureRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc private func handleRefreshControl() {
        setSnapshot()
        
        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    func errorAlert() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            let alert = UIAlertController(title: "데이터 로딩 실패", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
    }
}

extension ViewController {
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, BoxOfficeInformation>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let data = self.boxOfficeData[indexPath.row]
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCell.reuseIdentifier, for: indexPath) as? BoxOfficeCell else { return UICollectionViewListCell() }
            
            cell.updateComponents(data: data)
            
            return cell
        })
    }
    
    private func setSnapshot() {
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
