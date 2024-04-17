//
//  NumberFormatter+.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/16/24.
//

import Foundation

extension NumberFormatter {
    static let customNumberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        return formatter
    }()
    
    static func formatNumber(_ audience: String) -> String {
        let number = Int(audience)
        self.customNumberFormatter.numberStyle = .decimal
        return self.customNumberFormatter.string(for: number) ?? "0"
    }
}
