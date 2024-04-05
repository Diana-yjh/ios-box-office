//
//  MovieInfo.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/5/24.
//

struct MovieInformationDTO: Codable {
    let movieInformationResult: MovieInformationResult
}

struct MovieInformationResult: Codable {
    let movieInformation: MovieInformation
    let source: String
}

struct MovieInformation: Codable {
    let movieCode: String
    let movieName: String
    let movieEnglishName: String
    let movieOriginalName: String
    let productYear: String
    let showTime: String
    let openDate: String
    let productStateName: String
    let typeName: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]
    let staffs: [Staff]
    let sources: String
    
    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case movieEnglishName = "movieNmEn"
        case movieOriginalName = "movieNmOg"
        case productYear = "prdtYear"
        case showTime = "showTm"
        case openDate = "openDt"
        case productStateName = "prdtStatNm"
        case typeName = "typeNm"
        case nations
        case genres
        case directors
        case actors
        case showTypes
        case companys
        case audits
        case staffs
        case sources
    }
}

struct Nation: Codable {
    let nationName: String
    
    enum CodingKeys: String, CodingKey {
        case nationName = "nationNm"
    }
}

struct Genre: Codable {
    let genreName: String
    
    enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}

struct Director: Codable {
    let peopleName: String
    let peopleEnglishName: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
    }
}

struct Actor: Codable {
    let peopleName: String
    let peopleEnglishName: String
    let cast: String
    let englishCast: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
        case cast
        case englishCast = "castEn"
    }
}

struct ShowType: Codable {
    let showTypeGroupName: String
    let showTypeName: String
    
    enum CodingKeys: String, CodingKey {
        case showTypeGroupName = "showTypeGroupNm"
        case showTypeName = "showTypeNm"
    }
}

struct Company: Codable {
    let companyCode: String
    let companyName: String
    let companyEnglishName: String
    let companyPartName: String

    enum CodingKeys: String, CodingKey {
        case companyCode = "companyCd"
        case companyName = "companyNm"
        case companyEnglishName = "companyNmEn"
        case companyPartName = "companyPartNm"
    }
}

struct Audit: Codable {
    let auditNumber: String
    let watchGradeName: String
    
    enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}

struct Staff: Codable {
    let peopleName: String
    let peopleEnglishName: String
    let staffRoleName: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
        case staffRoleName = "staffRoleNm"
    }
}
