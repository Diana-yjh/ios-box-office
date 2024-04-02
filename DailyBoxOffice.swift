//
//  boxOfficeResult.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/2/24.
//

struct DailyBoxOffice: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
    
    enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange
        case dailyBoxOfficeList
    }
}

struct DailyBoxOfficeList: Codable {
    let squenceNumber: Int
    let rank: Int
    let rankIntensity: Int
    let rankOldAndNew: String
    let movieRepresentCode: Int
    let movieName: String
    let openDate: String
    let salesAmount: Int
    let salesShare: Double
    let salesIntensity: Int
    let salesChange: Int
    let salesAccumulation: Int
    let audienceCount: Int
    let audienceIntensity: Int
    let audienceChange: Int
    let audienceAccumulation: Int
    let screenCount: Int
    let showCount: Int
    
    enum CodingKeys: String, CodingKey {
        case squenceNumber = "rnum"
        case rank
        case rankIntensity = "rankInten"
        case rankOldAndNew
        case movieRepresentCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesIntensity = "salesInten"
        case salesChange
        case salesAccumulation = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceIntensity = "audiInten"
        case audienceChange
        case audienceAccumulation = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
