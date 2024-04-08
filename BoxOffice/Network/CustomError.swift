//
//  CustomError.swift
//  BoxOffice
//
//  Created by Yejin Hong on 4/8/24.
//

import Foundation

enum CustomError: Error {
    case valueNotFound
    case dataCorrupted
    case typeMismatched
    case keyNotFound
    case networkError
    case unknowned
    
    case httpResponseError
    case statusCodeError(Int)
    case emptyData
}
