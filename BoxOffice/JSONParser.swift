//
//  JSONParser.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/2/24.
//

import UIKit

struct JSONParser {
    mutating func parse() -> DailyBoxOffice? {
        let decoder = JSONDecoder()
        
        guard let jsonData = NSDataAsset(name: "box_office_sample") else { return nil }
        
        guard let decodedData = try? decoder.decode(DailyBoxOffice.self, from: jsonData.data) else { return nil }
        
        return decodedData
    }
}
