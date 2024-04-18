//
//  BoxOfficeDTO.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/18/24.
//

import UIKit

struct BoxOfficeInformationDTO: Hashable {
    let rank: String
    let rankIntensity: String
    let rankOldAndNew: String
    let movieRepresentCode: String
    let movieName: String
    let audienceCount: String
    let audienceAccumulation: String
    
    func checkIfNew() -> Bool {
        return rankOldAndNew == "NEW" ? true : false
    }
    
    func rankIntensityFormate() -> NSAttributedString {
        let number = Int(rankIntensity) ?? 0
        
        if number > 0 {
            return UILabel().asColor(color: .red, fullText: "▲\(abs(number))", targetString: "▲")
        } else if number < 0 {
            return UILabel().asColor(color: .systemBlue,
                                     fullText: "▼\(abs(number))", targetString: "▼")
        } else {
            return UILabel().asColor(color: .black, fullText: "-", targetString: "")
        }
    }
}
