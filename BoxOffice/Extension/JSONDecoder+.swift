//
//  JSONParser.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/2/24.
//

import UIKit

extension JSONDecoder {
    func decode<T: Decodable>(_ fileName: String, type: T.Type) -> T? {
        let decoder = JSONDecoder()
        
        guard let jsonData = NSDataAsset(name: fileName) else { return nil }
        guard let decodedData = try? decoder.decode(type, from: jsonData.data) else { return nil }
        
        return decodedData
    }
}
