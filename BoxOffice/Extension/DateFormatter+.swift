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
    
//    static func fetchYesterdayDate(dateFormatType: DateFormatType) -> String {
//        self.customDateFormatter.dateFormat = dateFormatType.rawValue
//        let yesterdayDate = Date() - 86400
//        return self.customDateFormatter.string(from: yesterdayDate)
//    }
    
    static func fetchYesterdayDate(dateFormatType: DateFormatType, dateComponents: DateComponents) -> String {
        self.customDateFormatter.dateFormat = dateFormatType.rawValue
        return self.customDateFormatter.string(for: Calendar.current.date(from: dateComponents)) ?? ""
    }
}
