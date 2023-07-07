//
//  UIImage+Extension.swift
//  Navigation
//
//  Created by Евгения Шевякова on 22.02.2022.
//
import UIKit

public extension UIImage {
    
    func alpha(_ value:CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
