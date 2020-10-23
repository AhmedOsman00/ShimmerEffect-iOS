//
//  UIColor+Gradient.swift
//  ShimmerEffect-iOS
//
//  Created by Ahmed Osman on 9/24/20.
//  Copyright © 2020 Ahmed Osman. All rights reserved.
//

import UIKit

extension UIColor {
    public static let shimmerGray = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
    
    fileprivate func isLight() -> Bool {
        guard let components = cgColor.components,
            components.count >= 3 else { return false }
        let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
        return !(brightness < 0.5)
    }
    
    fileprivate var complementaryColor: UIColor {
        return isLight() ? darker : lighter
    }
    
    fileprivate var lighter: UIColor {
        return adjust(by: 1.35)
    }
    
    fileprivate var darker: UIColor {
        return adjust(by: 0.94)
    }
    
    fileprivate func adjust(by percent: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s, brightness: b * percent, alpha: a)
    }
    
    public func makeGradient() -> [CGColor] {
        return [self, self.complementaryColor, self].map({ $0.cgColor })
    }
}
