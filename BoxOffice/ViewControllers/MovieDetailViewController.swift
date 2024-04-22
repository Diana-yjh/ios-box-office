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
    static let movieDetailLabelSize: CGFloat = 16
    
    var movieInformation: MovieInformation? = nil
    
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
    let movieDirectorStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        return stackView
    }()
    
    let movieDirectorTitleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: MovieDetailViewController.movieDetailLabelSize)
        label.text = "감독"
        label.textAlignment = .center
        
        return label
    }()
    
    let movieDirectorValueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: MovieDetailViewController.movieDetailLabelSize)
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - 제작연도
    
    let movieProductYearStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        return stackView
    }()
    
    let movieProductYearTitleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: MovieDetailViewController.movieDetailLabelSize)
        label.text = "제작연도"
        label.textAlignment = .center
        
        return label
    }()
    
    let movieProductYearValueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: MovieDetailViewController.movieDetailLabelSize)
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - 개봉일
    
    let movieOpenDateStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        return stackView
    }()
    
    let movieOpenDateTitleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: MovieDetailViewController.movieDetailLabelSize)
        label.text = "개봉일"
        label.textAlignment = .center
        
        return label
    }()
    
    let movieOpenDateValueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: MovieDetailViewController.movieDetailLabelSize)
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - 상영시간
    
    let movieShowTimeStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        return stackView
    }()
    
    let movieShowTimeTitleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: MovieDetailViewController.movieDetailLabelSize)
        label.text = "상영시간"
        label.textAlignment = .center
        
        return label
    }()
    
    let movieShowTimeValueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: MovieDetailViewController.movieDetailLabelSize)
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - 관람 등급
    
    let movieWatchGradeNameStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        return stackView
    }()
    
    let movieWatchGradeNameTitleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: MovieDetailViewController.movieDetailLabelSize)
        label.text = "관람 등급"
        label.textAlignment = .center
        
        return label
    }()
    
    let movieWatchGradeNameValueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: MovieDetailViewController.movieDetailLabelSize)
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - 제작국가
    
    let movieNationNameStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        return stackView
    }()
    
    let movieNationNameTitleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: MovieDetailViewController.movieDetailLabelSize)
        label.text = "제작국가"
        label.textAlignment = .center
        
        return label
    }()
    
    let movieNationNameValueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: MovieDetailViewController.movieDetailLabelSize)
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - 장르
    
    let movieGenreStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        return stackView
    }()
    
    let movieGenreTitleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: MovieDetailViewController.movieDetailLabelSize)
        label.text = "장르"
        label.textAlignment = .center
        
        return label
    }()
    
    let movieGenreValueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: MovieDetailViewController.movieDetailLabelSize)
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - 배우
    
    let movieActorStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        return stackView
    }()
    
    let movieActorTitleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: MovieDetailViewController.movieDetailLabelSize)
        label.text = "배우"
        label.textAlignment = .center
        
        return label
    }()
    
    let movieActorValueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: MovieDetailViewController.movieDetailLabelSize)
        label.numberOfLines = 0
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        configureUI()
        imageLoad()
    }
    
    init(movieInformation: MovieInformation) {
        self.movieInformation = movieInformation
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func imageLoad() {
        guard let movieName = movieInformation?.movieInformationResult.movieInformation.movieName else {
            return
        }
        
        guard let url = URL(string: "https://dapi.kakao.com/v2/search/image?query=\(movieName) 영화 포스터&page=1&size=1") else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET" // 요청에 사용할 HTTP 메서드 설정
        
        urlRequest.setValue("KakaoAK \(URLs.kakaoApiKey)", forHTTPHeaderField: "Authorization") // HTTP 헤더 설정
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("URLSession Error")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("Empty Data")
                return
            }
            
            do {
                let jsonData = try JSONDecoder().decode(KakaoSearchData.self, from: data)
                
                DispatchQueue.global().async {
                    guard let document = jsonData.documents.first, let url = URL(string: document.imageURL), let data = try? Data(contentsOf: url) else {
                        print("Empty Document")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.moviePosterImageView.image = UIImage(data: data)
                    }
                }
            } catch {
                print("Error parsing JSON response")
            }
        }
        
        task.resume()
    }
    
    func setConstraints() {
        view.addSubview(detailScrollView)
        detailScrollView.addSubview(detailContentView)
        
        [moviePosterImageView, movieDirectorStackView, movieProductYearStackView, movieOpenDateStackView, movieShowTimeStackView, movieWatchGradeNameStackView, movieNationNameStackView, movieGenreStackView, movieActorStackView].forEach {
            detailContentView.addSubview($0)
        }
        
        movieDirectorStackView.addArrangedSubview(movieDirectorTitleLabel)
        movieDirectorStackView.addArrangedSubview(movieDirectorValueLabel)
        
        movieProductYearStackView.addArrangedSubview(movieProductYearTitleLabel)
        movieProductYearStackView.addArrangedSubview(movieProductYearValueLabel)
        
        movieOpenDateStackView.addArrangedSubview(movieOpenDateTitleLabel)
        movieOpenDateStackView.addArrangedSubview(movieOpenDateValueLabel)
        
        movieShowTimeStackView.addArrangedSubview(movieShowTimeTitleLabel)
        movieShowTimeStackView.addArrangedSubview(movieShowTimeValueLabel)
        
        movieWatchGradeNameStackView.addArrangedSubview(movieWatchGradeNameTitleLabel)
        movieWatchGradeNameStackView.addArrangedSubview(movieWatchGradeNameValueLabel)
        
        movieNationNameStackView.addArrangedSubview(movieNationNameTitleLabel)
        movieNationNameStackView.addArrangedSubview(movieNationNameValueLabel)
        
        movieGenreStackView.addArrangedSubview(movieGenreTitleLabel)
        movieGenreStackView.addArrangedSubview(movieGenreValueLabel)
        
        movieActorStackView.addArrangedSubview(movieActorTitleLabel)
        movieActorStackView.addArrangedSubview(movieActorValueLabel)
        
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
            moviePosterImageView.heightAnchor.constraint(equalTo: safeArea.widthAnchor, constant: MovieDetailViewController.trailingPaddingConstant * 2),
            moviePosterImageView.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            moviePosterImageView.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: MovieDetailViewController.trailingPaddingConstant),
            
            movieDirectorStackView.topAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor, constant: MovieDetailViewController.topPaddingConstant),
            movieDirectorStackView.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            movieDirectorStackView.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: MovieDetailViewController.trailingPaddingConstant),
            
            movieDirectorTitleLabel.widthAnchor.constraint(equalTo: movieDirectorStackView.widthAnchor, multiplier: MovieDetailViewController.titleMultiplierConstant),
            
            movieProductYearStackView.topAnchor.constraint(equalTo: movieDirectorStackView.bottomAnchor, constant: MovieDetailViewController.gapPaddingConstant),
            movieProductYearStackView.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            movieProductYearStackView.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: MovieDetailViewController.trailingPaddingConstant),
            
            movieProductYearTitleLabel.widthAnchor.constraint(equalTo: movieProductYearStackView.widthAnchor, multiplier: MovieDetailViewController.titleMultiplierConstant),
            
            movieOpenDateStackView.topAnchor.constraint(equalTo: movieProductYearStackView.bottomAnchor, constant: MovieDetailViewController.gapPaddingConstant),
            movieOpenDateStackView.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            movieOpenDateStackView.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: MovieDetailViewController.trailingPaddingConstant),
            
            movieOpenDateTitleLabel.widthAnchor.constraint(equalTo: movieOpenDateStackView.widthAnchor, multiplier: MovieDetailViewController.titleMultiplierConstant),
            
            movieShowTimeStackView.topAnchor.constraint(equalTo: movieOpenDateStackView.bottomAnchor, constant: MovieDetailViewController.gapPaddingConstant),
            movieShowTimeStackView.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            movieShowTimeStackView.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: MovieDetailViewController.trailingPaddingConstant),
            
            movieShowTimeTitleLabel.widthAnchor.constraint(equalTo: movieShowTimeStackView.widthAnchor, multiplier: MovieDetailViewController.titleMultiplierConstant),
            
            movieWatchGradeNameStackView.topAnchor.constraint(equalTo: movieShowTimeStackView.bottomAnchor, constant: MovieDetailViewController.gapPaddingConstant),
            movieWatchGradeNameStackView.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            movieWatchGradeNameStackView.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: MovieDetailViewController.trailingPaddingConstant),
            
            movieWatchGradeNameTitleLabel.widthAnchor.constraint(equalTo: movieWatchGradeNameStackView.widthAnchor, multiplier: MovieDetailViewController.titleMultiplierConstant),
            
            movieNationNameStackView.topAnchor.constraint(equalTo: movieWatchGradeNameStackView.bottomAnchor, constant: MovieDetailViewController.gapPaddingConstant),
            movieNationNameStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            movieNationNameStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: MovieDetailViewController.trailingPaddingConstant),
            
            movieNationNameTitleLabel.widthAnchor.constraint(equalTo: movieNationNameStackView.widthAnchor, multiplier: MovieDetailViewController.titleMultiplierConstant),
            
            movieGenreStackView.topAnchor.constraint(equalTo: movieNationNameStackView.bottomAnchor, constant: MovieDetailViewController.gapPaddingConstant),
            movieGenreStackView.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            movieGenreStackView.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: MovieDetailViewController.trailingPaddingConstant),
            
            movieGenreTitleLabel.widthAnchor.constraint(equalTo: movieGenreStackView.widthAnchor, multiplier: MovieDetailViewController.titleMultiplierConstant),
            
            movieActorStackView.topAnchor.constraint(equalTo: movieGenreStackView.bottomAnchor, constant: MovieDetailViewController.gapPaddingConstant),
            movieActorStackView.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: MovieDetailViewController.leadingPaddingConstant),
            movieActorStackView.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: MovieDetailViewController.trailingPaddingConstant),
            movieActorStackView.bottomAnchor.constraint(equalTo: detailContentView.bottomAnchor, constant: MovieDetailViewController.bottomPaddingConstant),
            
            movieActorTitleLabel.widthAnchor.constraint(equalTo: movieActorStackView.widthAnchor, multiplier: MovieDetailViewController.titleMultiplierConstant),
        ])
    }
    
    func configureUI() {
        guard let movieInformation = movieInformation?.movieInformationResult.movieInformation else {
            return
        }
        
        self.navigationItem.title = movieInformation.movieName
        
        guard let movieInformationDirectors = movieInformation.directors,
              let movieInformationProductYear = movieInformation.productYear,
              let movieInformationOpenDate = movieInformation.openDate,
              let movieInformationShowTime = movieInformation.showTime,
              let movieInformationAudits = movieInformation.audits,
              let movieInformationNations = movieInformation.nations,
              let movieInformationGenres = movieInformation.genres,
              let movieInformationActors = movieInformation.actors else {
            return
        }
        
        movieDirectorValueLabel.text = "\(movieInformationDirectors.map { $0.peopleName }.joined(separator: ", "))"
        movieProductYearValueLabel.text = "\(movieInformationProductYear)"
        movieOpenDateValueLabel.text = "\(movieInformationOpenDate)"
        movieShowTimeValueLabel.text = "\(movieInformationShowTime)"
        movieWatchGradeNameValueLabel.text = "\(movieInformationAudits.map { $0.watchGradeName }.joined(separator: ", "))"
        movieNationNameValueLabel.text = "\(movieInformationNations.map { $0.nationName }.joined(separator: ", "))"
        movieGenreValueLabel.text = "\(movieInformationGenres.map { $0.genreName }.joined(separator: ", "))"
        movieActorValueLabel.text = "\(movieInformationActors.map { $0.peopleName }.joined(separator: ", "))"
    }
}
