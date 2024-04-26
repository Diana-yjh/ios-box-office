//
//  NetworkService.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/4/24.
//

import Foundation

enum KakaoSearchType {
    case image
    
    var urlString: String {
        switch self{
        case .image:
            return "\(URLs.KAKAO_IMAGE_SEARCH)"
        }
    }
}

struct KakaoSearchOption {
    var query: String
    var sort: searchResultSortingOption?
    var page: Int?
    var size: Int?
    
    enum searchResultSortingOption: String {
        case accuracy
        case recency
    }
}

final class NetworkService {
    static let shared = NetworkService()
    
    private init() { }
    
    func getURL(searchType: KakaoSearchType, searchOption: KakaoSearchOption) -> URL? {
        guard var urlComponents = URLComponents(string: searchType.urlString) else {
            return nil
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "query", value: searchOption.query),
            URLQueryItem(name: "sort", value: searchOption.sort?.rawValue ?? KakaoSearchOption.searchResultSortingOption.accuracy.rawValue),
            URLQueryItem(name: "page", value: String(searchOption.page ?? 1)),
            URLQueryItem(name: "size", value: String(searchOption.page ?? 1)),
        ]
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        return url
    }
    
    func loadKakaoSearchAPI<T: Decodable>(searchType: KakaoSearchType, dataType: T.Type, searchOption: KakaoSearchOption, completion: @escaping (_ result: Result<T, CustomError>) -> ()) {
        
        guard let url = getURL(searchType: searchType, searchOption: searchOption) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("KakaoAK \(URLs.kakaoApiKey)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let _ = error {
                completion(.failure(.networkError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.httpResponseError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.emptyData))
                return
            }
            
            let decodeResult = JSONDecoder().decode(safeData, type: dataType.self)
            
            completion(decodeResult)
        }
        
        task.resume()
    }
    
    func startLoad<T: Decodable>(url: URL, type: T.Type, completion: @escaping (_ result: Result<T, CustomError>) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.networkError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.httpResponseError))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.statusCodeError(httpResponse.statusCode)))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.emptyData))
                return
            }
            
            let decodeResult: Result = JSONDecoder().decode(safeData, type: type.self)
            
            completion(decodeResult)
        }
        
        task.resume()
    }
}
