
//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/22/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    static let topPaddingConstant: CGFloat = 20
    static let bottomPaddingConstant: CGFloat = -20
    static let leadingPaddingConstant: CGFloat = 20
    static let trailingPaddingConstant: CGFloat = -20
    static let gapPaddingConstant: CGFloat = 10
    static let titleMultiplierConstant: CGFloat = 0.2
    
    final let BODY_FONT: UIFont = FontConstants.BODY
    final let BODY_BOLD_FONT: UIFont = FontConstants.BODY_BOLD
    
    var movieInformationData: MovieInformationDetailDTO? = nil
    
    let detailScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        
        return scrollView
    }()
    
    let detailContentView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    let moviePosterImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // MARK: - 감독
    lazy var movieDirectorTitleLabel: UILabel = {
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BODY_BOLD_FONT
        label.text = "감독"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var movieDirectorValueLabel: UILabel = {
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BODY_FONT
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - 제작연도
    lazy var movieProductYearTitleLabel: UILabel = {
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BODY_BOLD_FONT
        label.text = "제작연도"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var movieProductYearValueLabel: UILabel = {
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BODY_FONT
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - 개봉일
    lazy var movieOpenDateTitleLabel: UILabel = {
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BODY_BOLD_FONT
        label.text = "개봉일"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var movieOpenDateValueLabel: UILabel = {
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BODY_FONT
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - 상영시간
    lazy var movieShowTimeTitleLabel: UILabel = {
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BODY_BOLD_FONT
        label.text = "상영시간"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var movieShowTimeValueLabel: UILabel = {
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BODY_FONT
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - 관람 등급
    lazy var movieWatchGradeNameTitleLabel: UILabel = {
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BODY_BOLD_FONT
        label.text = "관람 등급"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var movieWatchGradeNameValueLabel: UILabel = {
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BODY_FONT
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - 제작국가
    lazy var movieNationNameTitleLabel: UILabel = {
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BODY_BOLD_FONT
        label.text = "제작국가"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var movieNationNameValueLabel: UILabel = {
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BODY_FONT
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - 장르
    lazy var movieGenreTitleLabel: UILabel = {
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BODY_BOLD_FONT
        label.text = "장르"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var movieGenreValueLabel: UILabel = {
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BODY_FONT
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - 배우
    lazy var movieActorTitleLabel: UILabel = {
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BODY_BOLD_FONT
        label.text = "배우"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var movieActorValueLabel: UILabel = {
        let label = UILabel()
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BODY_FONT
        label.numberOfLines = 0
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        imageLoad()
        setConstraints()
    }
    
    init(movieInformationDTO: MovieInformationDetailDTO) {
        movieInformationData = movieInformationDTO
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func imageLoad() {
        guard let movieInformationData = movieInformationData else {
            return
        }
        
        let movieName = movieInformationData.movieName
        
        NetworkService.shared.loadKakaoSearchAPI(searchType: KakaoSearchType.image, dataType: KakaoSearchData.self, searchOption: KakaoSearchOption(query: "\(movieName) 영화 포스터", page: 1, size: 1)) { result in
            switch result {
            case .success(let data):
                guard let firstDocument = data.documents?.first else {
                    return
                }
                
                let firstDocumentDTO = firstDocument.toDTO()
                
                guard let url = URL(string: firstDocumentDTO.imageURL), let safeData = try? Data(contentsOf: url), let image = UIImage(data: safeData) else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.moviePosterImageView.image = image
                    self.moviePosterImageView.heightAnchor.constraint(equalTo: self.moviePosterImageView.widthAnchor, multiplier: image.size.height / image.size.width).isActive = true
                }
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func setConstraints() {
        view.addSubview(detailScrollView)
        
        detailScrollView.addSubview(detailContentView)
        
        detailScrollView.addSubview(moviePosterImageView)
        
        detailContentView.addSubview(movieDirectorTitleLabel)
        detailContentView.addSubview(movieDirectorValueLabel)
        
        detailContentView.addSubview(movieProductYearTitleLabel)
        detailContentView.addSubview(movieProductYearValueLabel)
        
        detailContentView.addSubview(movieOpenDateTitleLabel)
        detailContentView.addSubview(movieOpenDateValueLabel)
        
        detailContentView.addSubview(movieShowTimeTitleLabel)
        detailContentView.addSubview(movieShowTimeValueLabel)
        
        detailContentView.addSubview(movieWatchGradeNameTitleLabel)
        detailContentView.addSubview(movieWatchGradeNameValueLabel)
        
        detailContentView.addSubview(movieNationNameTitleLabel)
        detailContentView.addSubview(movieNationNameValueLabel)
        
        detailContentView.addSubview(movieGenreTitleLabel)
        detailContentView.addSubview(movieGenreValueLabel)
        
        detailContentView.addSubview(movieActorTitleLabel)
        detailContentView.addSubview(movieActorValueLabel)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            detailScrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            detailScrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            detailScrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            detailScrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            detailContentView.widthAnchor.constraint(equalTo: detailScrollView.widthAnchor),
            detailContentView.topAnchor.constraint(equalTo: detailScrollView.contentLayoutGuide.topAnchor),
            detailContentView.bottomAnchor.constraint(equalTo: detailScrollView.contentLayoutGuide.bottomAnchor),
            detailContentView.leadingAnchor.constraint(equalTo: detailScrollView.contentLayoutGuide.leadingAnchor),
            detailContentView.trailingAnchor.constraint(equalTo: detailScrollView.contentLayoutGuide.trailingAnchor),
            
            moviePosterImageView.topAnchor.constraint(equalTo: detailContentView.topAnchor, constant: MovieDetailViewController.topPaddingConstant),
            moviePosterImageView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, constant: MovieDetailViewController.trailingPaddingConstant * 2),
            moviePosterImageView.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            moviePosterImageView.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: MovieDetailViewController.trailingPaddingConstant),
            
            movieDirectorTitleLabel.topAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor, constant: MovieDetailViewController.topPaddingConstant),
            movieDirectorTitleLabel.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            
            movieProductYearTitleLabel.topAnchor.constraint(equalTo: movieDirectorTitleLabel.bottomAnchor, constant: MovieDetailViewController.topPaddingConstant),
            movieProductYearTitleLabel.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            
            movieOpenDateTitleLabel.topAnchor.constraint(equalTo: movieProductYearTitleLabel.bottomAnchor, constant: MovieDetailViewController.topPaddingConstant),
            movieOpenDateTitleLabel.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            
            movieShowTimeTitleLabel.topAnchor.constraint(equalTo: movieOpenDateTitleLabel.bottomAnchor, constant: MovieDetailViewController.topPaddingConstant),
            movieShowTimeTitleLabel.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            
            movieWatchGradeNameTitleLabel.topAnchor.constraint(equalTo: movieShowTimeTitleLabel.bottomAnchor, constant: MovieDetailViewController.topPaddingConstant),
            movieWatchGradeNameTitleLabel.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            
            movieNationNameTitleLabel.topAnchor.constraint(equalTo: movieWatchGradeNameTitleLabel.bottomAnchor, constant: MovieDetailViewController.topPaddingConstant),
            movieNationNameTitleLabel.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            
            movieGenreTitleLabel.topAnchor.constraint(equalTo: movieNationNameTitleLabel.bottomAnchor, constant: MovieDetailViewController.topPaddingConstant),
            movieGenreTitleLabel.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            
            movieActorTitleLabel.topAnchor.constraint(equalTo: movieGenreTitleLabel.bottomAnchor, constant: MovieDetailViewController.topPaddingConstant),
            movieActorTitleLabel.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            movieActorTitleLabel.bottomAnchor.constraint(equalTo: detailContentView.bottomAnchor, constant: MovieDetailViewController.bottomPaddingConstant),
            
            movieDirectorTitleLabel.trailingAnchor.constraint(equalTo: movieWatchGradeNameTitleLabel.trailingAnchor),
            movieProductYearTitleLabel.trailingAnchor.constraint(equalTo: movieWatchGradeNameTitleLabel.trailingAnchor),
            movieOpenDateTitleLabel.trailingAnchor.constraint(equalTo: movieWatchGradeNameTitleLabel.trailingAnchor),
            movieShowTimeTitleLabel.trailingAnchor.constraint(equalTo: movieWatchGradeNameTitleLabel.trailingAnchor),
            movieNationNameTitleLabel.trailingAnchor.constraint(equalTo: movieWatchGradeNameTitleLabel.trailingAnchor),
            movieGenreTitleLabel.trailingAnchor.constraint(equalTo: movieWatchGradeNameTitleLabel.trailingAnchor),
            movieActorTitleLabel.trailingAnchor.constraint(equalTo: movieWatchGradeNameTitleLabel.trailingAnchor),
            
            movieDirectorValueLabel.topAnchor.constraint(equalTo: movieDirectorTitleLabel.topAnchor),
            movieDirectorValueLabel.leadingAnchor.constraint(equalTo: movieDirectorTitleLabel.trailingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            movieDirectorValueLabel.bottomAnchor.constraint(equalTo: movieDirectorTitleLabel.bottomAnchor),
            movieDirectorValueLabel.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: MovieDetailViewController.trailingPaddingConstant),
            
            movieProductYearValueLabel.topAnchor.constraint(equalTo: movieProductYearTitleLabel.topAnchor),
            movieProductYearValueLabel.leadingAnchor.constraint(equalTo: movieProductYearTitleLabel.trailingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            movieProductYearValueLabel.bottomAnchor.constraint(equalTo: movieProductYearTitleLabel.bottomAnchor),
            movieProductYearValueLabel.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: MovieDetailViewController.trailingPaddingConstant),
            
            movieOpenDateValueLabel.topAnchor.constraint(equalTo: movieOpenDateTitleLabel.topAnchor),
            movieOpenDateValueLabel.leadingAnchor.constraint(equalTo: movieOpenDateTitleLabel.trailingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            movieOpenDateValueLabel.bottomAnchor.constraint(equalTo: movieOpenDateTitleLabel.bottomAnchor),
            movieOpenDateValueLabel.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: MovieDetailViewController.trailingPaddingConstant),
            
            movieShowTimeValueLabel.topAnchor.constraint(equalTo: movieShowTimeTitleLabel.topAnchor),
            movieShowTimeValueLabel.leadingAnchor.constraint(equalTo: movieShowTimeTitleLabel.trailingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            movieShowTimeValueLabel.bottomAnchor.constraint(equalTo: movieShowTimeTitleLabel.bottomAnchor),
            movieShowTimeValueLabel.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: MovieDetailViewController.trailingPaddingConstant),
            
            movieNationNameValueLabel.topAnchor.constraint(equalTo: movieNationNameTitleLabel.topAnchor),
            movieNationNameValueLabel.leadingAnchor.constraint(equalTo: movieNationNameTitleLabel.trailingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            movieNationNameValueLabel.bottomAnchor.constraint(equalTo: movieNationNameTitleLabel.bottomAnchor),
            movieNationNameValueLabel.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: MovieDetailViewController.trailingPaddingConstant),
            
            movieWatchGradeNameValueLabel.topAnchor.constraint(equalTo: movieWatchGradeNameTitleLabel.topAnchor),
            movieWatchGradeNameValueLabel.leadingAnchor.constraint(equalTo: movieWatchGradeNameTitleLabel.trailingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            movieWatchGradeNameValueLabel.bottomAnchor.constraint(equalTo: movieWatchGradeNameTitleLabel.bottomAnchor),
            movieWatchGradeNameValueLabel.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: MovieDetailViewController.trailingPaddingConstant),
            
            movieGenreValueLabel.topAnchor.constraint(equalTo: movieGenreTitleLabel.topAnchor),
            movieGenreValueLabel.leadingAnchor.constraint(equalTo: movieGenreTitleLabel.trailingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            movieGenreValueLabel.bottomAnchor.constraint(equalTo: movieGenreTitleLabel.bottomAnchor),
            movieGenreValueLabel.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: MovieDetailViewController.trailingPaddingConstant),
            
            movieActorValueLabel.topAnchor.constraint(equalTo: movieActorTitleLabel.topAnchor),
            movieActorValueLabel.leadingAnchor.constraint(equalTo: movieActorTitleLabel.trailingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            movieActorValueLabel.bottomAnchor.constraint(equalTo: movieActorTitleLabel.bottomAnchor),
            movieActorValueLabel.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: MovieDetailViewController.trailingPaddingConstant),
        ])
    }
    
    func configureUI() {
        guard let movieInformationData = movieInformationData else {
            return
        }
        
        navigationItem.title = movieInformationData.movieName
        
        movieDirectorValueLabel.text = "\(movieInformationData.directors.map { $0.peopleName }.joined(separator: ", "))"
        movieProductYearValueLabel.text = "\(movieInformationData.productYear)"
        movieOpenDateValueLabel.text = "\(movieInformationData.openDate)"
        movieShowTimeValueLabel.text = "\(movieInformationData.showTime)"
        movieWatchGradeNameValueLabel.text = "\(movieInformationData.audits.map { $0.watchGradeName }.joined(separator: ", "))"
        movieNationNameValueLabel.text = "\(movieInformationData.nations.map { $0.nationName }.joined(separator: ", "))"
        movieGenreValueLabel.text = "\(movieInformationData.genres.map { $0.genreName }.joined(separator: ", "))"
        movieActorValueLabel.text = "\(movieInformationData.actors.map { $0.peopleName }.joined(separator: ", "))"
    }
}
