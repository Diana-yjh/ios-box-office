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
    private var defaults = UserDefaults.standard
    private lazy var cellMode: CellMode = (defaults.value(forKey: "modeKey") as? String ?? "리스트" == "리스트") ? .list : .icon
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: view.bounds.width,
                                                            height: view.bounds.height - 100),
                                              collectionViewLayout: self.createCollectionViewListLayout())
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
        switch self.cellMode {
        case .list:
            self.collectionView.collectionViewLayout = self.createCollectionViewListLayout()
            self.configureDataSource(.list)
            self.configureUI()
        case .icon:
            self.collectionView.collectionViewLayout = self.createCollectionViewIconLayout()
            self.configureDataSource(.icon)
            self.configureUI()
        }
        configureCollectionView()
        configureMain()
        
        collectionView.delegate = self
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
        
        NetworkService.shared.startLoad(url: url, type: BoxOffice.self) { result in
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
    
    private func createCollectionViewListLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    private func createCollectionViewIconLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = CGFloat(10)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let configuration = UICollectionViewCompositionalLayout(section: section)
        
        return configuration
    }
    
    @objc private func selectCalendarDate(sender: AnyObject) {
        let vc = CalendarViewController()
        vc.delegate = self
        vc.selectedDateComponents = selectedDateComponents
        
        present(vc, animated: true)
    }
    
    @objc private func changeMode(sender: AnyObject) {
        cellMode = (defaults.value(forKey: "modeKey") as? String == "리스트") ? .icon : .list
        
        let alert = UIAlertController(title: "화면모드 변경", message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "\(cellMode.name)", style: .default) { _ in
            self.defaults.setValue(self.cellMode.name, forKey: "modeKey")
            switch self.cellMode {
            case .list:
                self.collectionView.collectionViewLayout = self.createCollectionViewListLayout()
                self.configureDataSource(.list)
                self.configureUI()
            case .icon:
                self.collectionView.collectionViewLayout = self.createCollectionViewIconLayout()
                self.configureDataSource(.icon)
                self.configureUI()
            }
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
    private func configureDataSource(_ mode: CellMode) {
        dataSource = UICollectionViewDiffableDataSource<Int, BoxOfficeInformationDTO>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let data = self.boxOfficeData[indexPath.row]
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCell.IDENTIFIER, for: indexPath) as? BoxOfficeCell else { return UICollectionViewListCell() }
            cell.cellMode = self.cellMode
            cell.configure()
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

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = self.boxOfficeData[indexPath.row]
        
        let urlString = URLs.PREFIX + URLs.MOVIE_DETAIL + "\(data.movieRepresentCode)"
        guard let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        guard let url = URL(string: encodedUrlString) else { return }
        
        NetworkService.shared.startLoad(url: url, type: MovieInformation.self) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let vc = MovieDetailViewController(movieInformationDTO: data.movieInformationResult.movieInformation.toDTO())
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
