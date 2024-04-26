//
//  String+.swift
//  BoxOffice
//
//  Created by H on 4/26/24.
//

import Foundation

extension String {
    func formatDate() -> String {
        guard self.count == 8 else { return self }
        
        let yearStartIndex = self.index(self.startIndex, offsetBy: 0)
        let yearEndIndex = self.index(self.startIndex, offsetBy: 3)
        
        let monthStartIndex = self.index(self.startIndex, offsetBy: 4)
        let monthEndIndex = self.index(self.startIndex, offsetBy: 5)
        
        let dayStartIndex = self.index(self.startIndex, offsetBy: 6)
        let dayEndIndex = self.index(self.startIndex, offsetBy: 7)
        
        let yearString = String(self[yearStartIndex...yearEndIndex])
        let monthString = String(self[monthStartIndex...monthEndIndex])
        let dayString = String(self[dayStartIndex...dayEndIndex])
        
        return yearString + "-" + monthString + "-" + dayString
    }
}
