//
//  URLs.swift
//  BoxOffice
//
//  Created by Gama, Diana, Danny on 4/5/24.
//

import Foundation

struct URLs {
    static let apiKey = Bundle.main.apiKey ?? ""
    static let kakaoApiKey = Bundle.main.kakaoApiKey ?? ""
    
    static let PREFIX = "https://kobis.or.kr/kobisopenapi/webservice/rest/"
    
    static let DAILY_BOX_OFFICE = "boxoffice/searchDailyBoxOfficeList.json?key=\(apiKey)&targetDt="
    static let MOVIE_DETAIL = "movie/searchMovieInfo.json?key=\(apiKey)&movieCd="
}
