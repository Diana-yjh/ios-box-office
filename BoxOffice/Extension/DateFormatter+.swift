//
//  DateFormatter+.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/5/24.
//

import Foundation

extension DateFormatter {
    func fetchTodayDate() -> String {
        self.dateFormat = "yyyyMMdd"
        return self.string(from: Date())
    }
}
