//
//  JSONDecoder.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/2/24.
//

import UIKit

extension JSONDecoder {
    func decode<T: Decodable>(_ data: Data, type: T.Type) -> Result<T, CustomError> {
        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(type, from: data)
            return .success(decodedData)
        } catch let error {
            guard let decodingError = error as? DecodingError else {
                print("This is UnKnown Error")
                return .failure(.unknowned)
            }

            switch decodingError {
            case .dataCorrupted(_):
                return .failure(.dataCorrupted)
            case .keyNotFound(_, _):
                return .failure(.keyNotFound)
            case .typeMismatch(_, _):
                return .failure(.typeMismatched)
            case .valueNotFound(_, _):
                return .failure(.valueNotFound)
            default:
                return .failure(.unknowned)
            }
        }
    }
}
