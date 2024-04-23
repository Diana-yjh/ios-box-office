//
//  KakaoSearchData.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/22/24.
//

import Foundation

struct KakaoSearchData: Codable {
    let documents: [Document]?
    let meta: Meta?
}

struct Document: Codable {
    let collection: String?
    let datetime: String?
    let displaySiteName: String?
    let docURL: String?
    let height: Int?
    let imageURL: String?
    let thumbnailURL: String?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case collection
        case datetime
        case displaySiteName = "display_sitename"
        case docURL = "doc_url"
        case height
        case imageURL = "image_url"
        case thumbnailURL = "thumbnail_url"
        case width
    }
}

struct Meta: Codable {
    let isEnd: Bool?
    let pageableCount: Int?
    let totalCount: Int?

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}

extension Document {
    func toDTO() -> KakaoSearchDataDocumentDTO {
        return KakaoSearchDataDocumentDTO(imageURL: imageURL ?? "")
    }
}
