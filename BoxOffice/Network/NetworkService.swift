//
//  NetworkService.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/4/24.
//

import Foundation

class NetworkService {
    let urltoString = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=APIKEY&targetDt=20240101"
    
    func startLoad() {
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
