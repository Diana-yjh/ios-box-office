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
            print("API KEY 값을 로드하지 못했습니다.")
            return
        }
        
        let urltoString = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(apiKey)&targetDt=20240101"
        
        guard let url = URL(string: urltoString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print(response)
                return
            }
            
            guard let safeData = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movieData = try decoder.decode(BoxOffice.self, from: safeData)
                print(movieData)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

extension Bundle {
    var apiKey: String? {
        return infoDictionary?["API_KEY"] as? String
    }
}
