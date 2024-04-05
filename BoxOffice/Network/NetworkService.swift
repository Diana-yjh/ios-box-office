//
//  NetworkService.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/4/24.
//

import Foundation

class NetworkService {
    func startLoad() {
        guard let apiKey = Bundle.main.apiKey else {
            fatalError("API KEY 값을 로드하지 못했습니다.")
        }
        
        let urltoString = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(apiKey)&targetDt=20240101"
        
        guard let url = URL(string: urltoString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                fatalError("Error: \(error)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                fatalError("Response Statuscode: \(httpResponse.statusCode)")
            }
            
            guard let safeData = data else {
                return
            }
            
            guard let movieData = JSONDecoder().decode(safeData, type: BoxOffice.self) else {
                return
            }
            
            print(movieData)
        }
        task.resume()
    }
}

extension Bundle {
    var apiKey: String? {
        return infoDictionary?["API_KEY"] as? String
    }
}
