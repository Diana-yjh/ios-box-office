//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

struct Temp: Hashable {//이후에 사용 or 수정
    var movieTitle: String
    var audience: String
}

class ViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Temp>!
    var tempData: [Temp] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = DateFormatter.fetchYesterdayDate(dateFormatType: .navigationTitle)
        
        tempData = [
            Temp(movieTitle: "제목1", audience: "관객수"),
            Temp(movieTitle: "제목2", audience: "관객수2"),
            Temp(movieTitle: "제목3", audience: "관객수3"),
            Temp(movieTitle: "제목4", audience: "관객수4"),
        ]
        
        configureCollectionView()
        configureDataSource()
        setSnapshot()
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
        dataSource = UICollectionViewDiffableDataSource<Int, Temp>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCell.reuseIdentifier, for: indexPath) as? BoxOfficeCell else {
                print("?")
                return UICollectionViewCell()
            }
            //cell에 데이터 넣어주고 싶으면 cell.parameter = Data 해서 넣어주기~~
            
            cell.rankNumberLabel.text = "\(indexPath.row)"
            cell.rankChangeLabel.text = "순위 변동 라벨"
            
            cell.titleLabel.text = "영화 제목"
            cell.audienceLabel.text = "오늘 Z,ZZZ명 / 총 XX,XXX명"
            
            print("\(cell.rankNumberLabel.text)")
            
            return cell
        })
    }
    
    func setSnapshot() {
//        if dataSource == nil { return } //불필요하지만 처음 설정 때 없으면 에러 나더라구요? ㅎㅎㅎㅎㅎㅎ\\
        
        var snapShot = NSDiffableDataSourceSnapshot<Int, Temp>()
        let section = Array(0...1) //저희는 근데 섹션 한개쓸거라 ㅋㅋ.. 근데 방법을 모름..
        snapShot.appendSections(section)
////        snapShot.appendItems(tempData!, toSection: 0)//강제옵셔널 수정!!
        snapShot.appendItems(tempData, toSection: 0)
        
//        snapShot.appendSections([0])
//        snapShot.appendItems(tempData)
        dataSource.apply(snapShot)
    }
}
