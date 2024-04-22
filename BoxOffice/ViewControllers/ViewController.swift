//
//  ViewController.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 13/01/23.
//

import UIKit

enum CellMode: String {
    case list
    case icon
    
    var name: String {
        switch self {
        case .list:
            return "리스트"
        case .icon:
            return "아이콘"
        }
    }
}

class ViewController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<Int, BoxOfficeInformationDTO>!
    private var boxOfficeData: [BoxOfficeInformationDTO] = []
    private var selectedDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date.yesterday)
    private var cellMode: CellMode = .list
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: view.bounds.width,
                                                            height: view.bounds.height - 100),
                                              collectionViewLayout: self.createCollectionViewLayout())
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
    
    private lazy var modeButton: UIButton = {
        let button = UIButton()
        button.setTitle("화면 모드 변경", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeMode), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = calendarButton
        configureCollectionView()
        configureDataSource()
        configureMain()
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
    
    private func configureMain() {
        view.backgroundColor = .systemGray6
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
                guard let boxOfficeData = data.boxOfficeResults?.boxOffices else { 
                    self.activityIndicator.stopAnimating()
                    self.errorAlert(.emptyData)
                    return
                }
                self.boxOfficeData = boxOfficeData.map { $0.toDTO() }
                completion()
            case .failure(let error):
                self.errorAlert(error)
            }
        }
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
    
    @objc private func changeMode(sender: AnyObject) {
        cellMode = (cellMode == .list) ? .icon : .list
        
        let alert = UIAlertController(title: "화면모드 변경", message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "\(cellMode.name)", style: .default) { _ in
            print(self.cellMode.name)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func errorAlert(_ error: CustomError) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            let alert = UIAlertController(title: "데이터 로딩 실패하였습니다. 재시도 할까요? \(error)", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
    }
}

extension ViewController {
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, BoxOfficeInformationDTO>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let data = self.boxOfficeData[indexPath.row]
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCell.IDENTIFIER, for: indexPath) as? BoxOfficeCell else { return UICollectionViewListCell() }
            
            cell.updateComponents(data: data)
            
            return cell
        })
    }
    
    private func setSnapshot() {
        if dataSource == nil { return }
        
        var snapShot = NSDiffableDataSourceSnapshot<Int, BoxOfficeInformationDTO>()
        let section = Array(0...1)
        snapShot.appendSections(section)
        snapShot.appendItems(boxOfficeData, toSection: 0)
        dataSource.apply(snapShot)
    }
}

extension ViewController {
    private func configureModeButton() {
        view.addSubview(modeButton)
        
        NSLayoutConstraint.activate([
            modeButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            modeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            modeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            modeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureCollectionView() {
        collectionView.register(BoxOfficeCell.self, forCellWithReuseIdentifier: BoxOfficeCell.IDENTIFIER)
        
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        
        configureRefreshControl()
        configureModeButton()
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
}

extension ViewController: SendDataDelegate {
    func updateDate(dateComponents: DateComponents) {
        activityIndicator.startAnimating()
        selectedDateComponents = dateComponents
        configureUI()
    }
}
