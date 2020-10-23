//
//  ShimmerView.swift
//  ShimmerEffect-iOS
//
//  Created by Ahmed Osman on 9/24/20.
//  Copyright © 2020 Ahmed Osman. All rights reserved.
//

import UIKit

class ShimmerView: UIView {
    
    weak var shimmerLayer: CALayer?
    static let shimmerLayerKey = "shimmerEffect"
    var shimmerProperties: ShimmerProperties
    
    override var bounds: CGRect {
        didSet {
            guard let shimmerLayer = shimmerLayer else { return }
            shimmerLayer.frame = self.bounds
        }
    }
    
    init(frame: CGRect, properties: ShimmerProperties) {
        self.shimmerProperties = properties
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = self.shimmerProperties.backgroundColor
        shimmerLayer = addShimmerGradientLayer(to: self)
        addShimmerEffect(to: layer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard let shimmerLayer = shimmerLayer else { return }
        addShimmerEffect(to: shimmerLayer)
    }
    
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        guard let shimmerLayer = shimmerLayer else { return }
        addShimmerEffect(to: shimmerLayer)
    }
    
    func addShimmerGradientLayer(to view: UIView) -> CALayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = shimmerProperties.gradientColors
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
        return gradientLayer
    }
    
    func addShimmerEffect(to layer: CALayer) {
        let animation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.locations))
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2]
        animation.repeatCount = .infinity
        animation.duration = shimmerProperties.duration
        layer.add(animation, forKey: ShimmerView.shimmerLayerKey)
    }
}
