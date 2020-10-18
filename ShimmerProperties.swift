//
//  ShimmerProperties.swift
//  ShimmerEffect-iOS
//
//  Created by Ahmed Osman on 9/24/20.
//  Copyright © 2020 Ahmed Osman. All rights reserved.
//

import UIKit

@objc
class ShimmerProperties: NSObject {
    var backgroundColor: UIColor
    var gradientColors: [CGColor]
    var duration: CFTimeInterval
    
    init(backgroundColor: UIColor = .shimmerGray, gradientColors: [CGColor] = UIColor.shimmerGray.makeGradient(), duration: CFTimeInterval = 1.5) {
        self.backgroundColor = backgroundColor
        self.gradientColors = gradientColors
        self.duration = duration
    }
}
