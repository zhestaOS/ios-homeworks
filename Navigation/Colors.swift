//
//  Colors.swift
//  Navigation
//
//  Created by Евгения Шевякова on 05.11.2023.
//

import UIKit

extension UIColor {
    private static func themedColor(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? light : dark
        }
    }
}

extension UIColor {
    static var vkBackgroundColor: UIColor {
        themedColor(light: .white, dark: .darkGray)
    }
    
    static var vkTextMainColor: UIColor {
        themedColor(light: .black, dark: .white)
    }
}
