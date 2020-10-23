//
//  ShimmerProperties.swift
//  ShimmerEffect-iOS
//
//  Created by Ahmed Osman on 9/24/20.
//  Copyright © 2020 Ahmed Osman. All rights reserved.
//

import UIKit

@objc
public class ShimmerProperties: NSObject {
    public var backgroundColor: UIColor
    public var gradientColors: [CGColor]
    public var duration: CFTimeInterval
    
    public init(backgroundColor: UIColor = .shimmerGray, gradientColors: [CGColor] = UIColor.shimmerGray.makeGradient(), duration: CFTimeInterval = 1.5) {
        self.backgroundColor = backgroundColor
        self.gradientColors = gradientColors
        self.duration = duration
    }
}
