//
//  Bundle+.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/5/24.
//

import Foundation

extension Bundle {
    var apiKey: String? {
        let key = infoDictionary?["API_KEY"] as? String
        if key == "" {
            fatalError("API_KEY 값을 입력해주세요.")
        } else {
            return key
        }
    }
}
