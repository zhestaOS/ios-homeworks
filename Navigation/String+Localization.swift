//
//  String+Localization.swift
//  Navigation
//
//  Created by Евгения Шевякова on 04.11.2023.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
    
    func localized(_ args: CVarArg...) -> String {
        return String(format: localized, args)
    }
}
