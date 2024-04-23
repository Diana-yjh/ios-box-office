//
//  Constants.swift
//  BoxOffice
//
//  Created by Yejin Hong on 4/23/24.
//
import UIKit

struct FontConstants {
    static let TITLE1: UIFont = .preferredFont(forTextStyle: .title1)
    static let TITLE2: UIFont = .preferredFont(forTextStyle: .title2)
    static let TITLE3: UIFont = .preferredFont(forTextStyle: .title3)
    static let TITLE3_BOLD: UIFont = .init(descriptor: UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title3).withSymbolicTraits(.traitBold)!,
                                           size: 0.0)
    
    static let BODY: UIFont = .preferredFont(forTextStyle: .body)
    static let BODY_BOLD: UIFont = .init(descriptor:UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).withSymbolicTraits(.traitBold)!,
                                         size: 0.0)
}
