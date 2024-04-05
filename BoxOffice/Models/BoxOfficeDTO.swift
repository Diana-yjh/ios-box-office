//
//  boxOfficeResult.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/2/24.
//

struct BoxOfficeDTO: Codable {
    let boxOfficeResults: BoxOfficeResults
    
    enum CodingKeys: String, CodingKey {
        case boxOfficeResults = "boxOfficeResult"
    }
}

struct BoxOfficeResults: Codable {
    let boxOfficeType: String
    let showRange: String
    let boxOffices: [BoxOfficeInformation]
    
    enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange
        case boxOffices = "dailyBoxOfficeList"
    }
}

struct BoxOfficeInformation: Codable {
    let squenceNumber: String
    let rank: String
    let rankIntensity: String
    let rankOldAndNew: String
    let movieRepresentCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesIntensity: String
    let salesChange: String
    let salesAccumulation: String
    let audienceCount: String
    let audienceIntensity: String
    let audienceChange: String
    let audienceAccumulation: String
    let screenCount: String
    let showCount: String
    
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
        case audienceChange = "audiChange"
        case audienceAccumulation = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
