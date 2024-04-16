//
//  NetworkService.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/4/24.
//

import Foundation

class NetworkService {
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
