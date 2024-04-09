//
//  DateFormatter+.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/5/24.
//

import Foundation

extension DateFormatter {
    enum DateFormatType: String {
        case api = "yyyyMMdd"
        case navigationTitle = "yyyy-MM-dd"
    }
    
    static let customDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    static func fetchTodayDate(dateFormatType: DateFormatType) -> String {
        self.customDateFormatter.dateFormat = dateFormatType.rawValue
        return self.customDateFormatter.string(from: Date())
    }
}
