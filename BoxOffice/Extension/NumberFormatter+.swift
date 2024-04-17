//
//  NumberFormatter+.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/16/24.
//

import Foundation

extension NumberFormatter {
    func numberFormat(_ audience: String) -> String {
        let number = Int(audience)
        self.numberStyle = .decimal
        return self.string(for: number) ?? "0"
    }
}
