//
//  UILabel+.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/16/24.
//

import UIKit

extension UILabel {
    func asColor(color: UIColor, fullText: String, targetString: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        return attributedString
    }
}
