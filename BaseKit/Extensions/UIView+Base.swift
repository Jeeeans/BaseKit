//
//  UIView+Base.swift
//  BaseKit
//
//  Created by 진성준 on 2021/08/11.
//

import UIKit

public extension UIView {
    
    static func initFromNib() -> Self {
        
        func instanceFromNib<T: UIView>() -> T {
            
            return Bundle.main.loadNibNamed(String(describing: self), owner: self, options: nil)?[0] as! T
        }
        
        return instanceFromNib()
    }
    
    var parentViewController: UIViewController? {
        
        var parentResponder: UIResponder? = self
        
        while true {
            
            guard let nextResponder = parentResponder?.next else { return nil }
            
            if let viewController = nextResponder as? UIViewController {
                
                return viewController
            }
            
            parentResponder = nextResponder
        }
    }
    
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }
    
    func addConstraints(withFormat: String, views: UIView...) {
        
        var viewsDictionary: [String: UIView] = [:]
        
        for (index, view) in views.enumerated() {
            
            let key = "v\(index)"
            
            view.translatesAutoresizingMaskIntoConstraints = false
            
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: withFormat, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func addSubviewToMatchParent(_ subView: UIView!) {
        
        self.addSubview(subView)
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        subView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        subView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        subView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        subView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.layoutIfNeeded()
    }
    
    func removeAllSubViews() {
        self.subviews.forEach { subView in
            subView.removeFromSuperview()
        }
    }
    
    @discardableResult
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        topConstant: CGFloat = 0,
        leftConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        rightConstant: CGFloat = 0,
        widthConstant: CGFloat = 0,
        heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({ $0.isActive = true })
        
        return anchors
    }
    
    func anchorCenterXToSuperview(constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let anchor = superview?.centerXAnchor {
            
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    func anchorCenterYToSuperview(constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let anchor = superview?.centerYAnchor {
            
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    func anchorCenterSuperview() {
        
        anchorCenterXToSuperview()
        
        anchorCenterYToSuperview()
    }
    
    func findConstraint(attribute: NSLayoutConstraint.Attribute, for view: UIView) -> NSLayoutConstraint? {
        
        let constraint = constraints.first {
            
            ($0.firstAttribute == attribute && $0.firstItem as? UIView == view) ||
                ($0.secondAttribute == attribute && $0.secondItem as? UIView == view)
        }
        
        return constraint ?? superview?.findConstraint(attribute: attribute, for: view)
    }
    
    var widthConstraint: NSLayoutConstraint? {
        
        findConstraint(attribute: .width, for: self)
    }
    
    var heightConstraint: NSLayoutConstraint? {
        
        findConstraint(attribute: .height, for: self)
    }
    
    var leadingConstraint: NSLayoutConstraint? {
        
        findConstraint(attribute: .leading, for: self)
    }
    
    var trailingConstraint: NSLayoutConstraint? {
        
        findConstraint(attribute: .trailing, for: self)
    }
    
    var topConstraint: NSLayoutConstraint? {
        
        findConstraint(attribute: .top, for: self)
    }
    
    var bottomConstraint: NSLayoutConstraint? {
        
        findConstraint(attribute: .bottom, for: self)
    }
    
    func ancestorView(where predicate: (UIView?) -> Bool) -> UIView? {
        
        if predicate(superview) { return superview }
        
        return superview?.ancestorView(where: predicate)
    }
    
    func ancestorView<T: UIView>(withClass name: T.Type) -> T? {
        
        return ancestorView(where: { $0 is T }) as? T
    }
    
    func circle(borderWidth: CGFloat, borderColor: UIColor) {
        
        self.layer.cornerRadius = self.frame.size.width / 2
        
        self.layer.borderWidth = borderWidth
        
        self.layer.borderColor = borderColor.cgColor
        
        self.clipsToBounds = true
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        
        let shape = CAShapeLayer()
        
        shape.path = maskPath.cgPath
        
        layer.mask = shape
    }
    
    func cornerRadius(_ radius: CGFloat) {
        
        self.layer.cornerRadius = radius
        
        self.layer.masksToBounds = false
    }
    
    func addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
        
        layer.shadowColor = color.cgColor
        
        layer.shadowOffset = offset
        
        layer.shadowRadius = radius
        
        layer.shadowOpacity = opacity
        
        layer.masksToBounds = false
    }
    
    func fadeIn(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        
        if isHidden { isHidden = false }
        
        UIView.animate(withDuration: duration, animations: { self.alpha = 1 }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        
        if isHidden { isHidden = false }
        
        UIView.animate(withDuration: duration, animations: { self.alpha = 0 }, completion: completion)
    }
    
    func scale(by offset: CGPoint, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        
        if animated {
            
            UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
                
                self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
                
            }, completion: completion)
            
        } else {
            
            transform = transform.scaledBy(x: offset.x, y: offset.y)
            
            completion?(true)
        }
    }
    
    func firstResponder() -> UIView? {
        
        var views = [UIView](arrayLiteral: self)
        
        var index = 0
        
        repeat {
            
            let view = views[index]
            
            if view.isFirstResponder { return view }
            
            views.append(contentsOf: view.subviews)
            
            index += 1
            
        } while index < views.count
        
        return nil
    }
}



// MARK: -
extension UIView {
    
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    public var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    public func borderOutside(width: CGFloat, color: UIColor) {
        self.frame = self.frame.insetBy(dx: -width, dy: -width)
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
