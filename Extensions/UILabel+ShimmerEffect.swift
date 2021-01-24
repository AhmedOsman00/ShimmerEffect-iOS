//
//  UILabel+ShimmerEffect.swift
//  FBSnapshotTestCase
//
//  Created by Ahmed Osman on 22/11/2020.
//

import Foundation

extension UILabel {
    
    static var multiLine = "labelMultiLine"
    
    @IBInspectable var showShimmerAsMultiLines: Bool {
        get { return objc_getAssociatedObject(self, &UILabel.multiLine) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &UILabel.multiLine, newValue, AssociationPolicy.retainNonatomic.objc) }
    }
    
    var lineHeight: CGFloat {
        return font?.lineHeight ?? 16
    }
    
    var numberOfShimmerLines: Int {
        let height = intrinsicContentSize.height
        return self.numberOfLines == 0 ? Int(height/lineHeight) : self.numberOfLines
    }
    
    func createView() -> (UIView, UIStackView) {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = self.backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        let stackView = UIStackView(frame: self.bounds)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        view.pinTo(view: stackView)
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 5
        return (view, stackView)
    }
    
    func createShimmerView(stackView: UIStackView) {
        let shimmerView = ShimmerView(frame: CGRect(x: 0, y: 0, width: 0, height: lineHeight), properties: ShimmerProperties())
        shimmerView.tag = -1
        shimmerView.heightAnchor.constraint(equalToConstant: lineHeight).isActive = true
        stackView.addArrangedSubview(shimmerView)
    }
    
    override func addShimmerView(to shimmerView: UIView, with properties: ShimmerProperties) {
        if showShimmerAsMultiLines {
            let (view, stackView) = createView()
            for _ in 0..<numberOfShimmerLines {
                createShimmerView(stackView: stackView)
            }
            self.addSubview(view)
            self.bringSubviewToFront(view)
            view.pinTo(view: self)
        }else{
            super.addShimmerView(to: shimmerView, with: properties)
        }
    }
}
