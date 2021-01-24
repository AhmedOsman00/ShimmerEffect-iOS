//
//  UITextView+ShimmerEffect.swift
//  FBSnapshotTestCase
//
//  Created by Ahmed Osman on 22/11/2020.
//

import Foundation

extension UITextView {
    
    static var multiLine = "textViewMultiLine"
    
    @IBInspectable var showShimmerAsMultiLines: Bool {
        get { return objc_getAssociatedObject(self, &UITextView.multiLine) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &UITextView.multiLine, newValue, AssociationPolicy.retainNonatomic.objc) }
    }
    
    var lineHeight: CGFloat {
        return font?.lineHeight ?? 16
    }
    
    var numberOfLines: Int {
        let height = intrinsicContentSize.height
        return Int(height / lineHeight)
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
    
    func pinView(view: UIView) {
        self.addSubview(view)
        self.bringSubviewToFront(view)
        view.pinTo(view: self)
        view.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
            
    override func addShimmerView(to shimmerView: UIView, with properties: ShimmerProperties) {
        if showShimmerAsMultiLines {
            let (view, stackView) = createView()
            for _ in 0..<numberOfLines {
                createShimmerView(stackView: stackView)
            }
            pinView(view: view)
        }else{
            let view = ShimmerView(frame: self.bounds, properties: properties)
            view.tag = -1
            view.translatesAutoresizingMaskIntoConstraints = false
            pinView(view: view)
        }
    }
}
