//
//  JSONDecoder.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/2/24.
//

import UIKit

extension JSONDecoder {
    func decode<T: Decodable>(_ data: Data, type: T.Type) -> T? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(type, from: data)
            return decodedData
        } catch let error {
            guard let error = error as? DecodingError else {
                print("This is UnKnown Error")
                return nil
            }
            
            switch error {
            case .dataCorrupted(let context):
                print("dataCorrupted:", context)
            case .keyNotFound(_, let context):
                print("keyNotFound:", context)
            case .typeMismatch(let typeName, let context):
                print("typeMismatch:", context)
            case .valueNotFound(let typeName, let context):
                print("valueNotFound:", context)
            default:
                print("This is an Unknown Error")
            }
        }
        return nil
    }
}
