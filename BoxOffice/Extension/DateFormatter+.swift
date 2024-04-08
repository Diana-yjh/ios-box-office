//
//  DateFormatter+.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/5/24.
//

import Foundation

extension DateFormatter {
    static let customDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    static func fetchTodayDate() -> String {
        self.customDateFormatter.dateFormat = "yyyyMMdd"
        return self.customDateFormatter.string(from: Date())
    }
}
