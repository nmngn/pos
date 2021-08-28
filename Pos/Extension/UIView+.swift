//
//  UIView+.swift
//  Pos
//
//  Created by Nam Ngây on 28/08/2021.
//

import Foundation
import UIKit

protocol XibView {
    static var name: String { get }
    static func createFromXib() -> Self
}

extension XibView where Self: UIView {
    static var name: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
    
    static func createFromXib() -> Self {
        return Self.init()
    }
}

extension UIView: XibView { }

extension UIView {
    
    func makeBorderColor() {
        self.layer.do {
            $0.borderWidth = 0.5
            $0.borderColor = UIColor(red: 0.68, green: 0.68, blue: 0.68, alpha: 0.5).cgColor
        }
    }
    
    func makeShadow() {
        self.layer.do {
            $0.masksToBounds = false
            $0.shadowColor = UIColor(red: 1, green: 18, blue: 34, alpha: 0.05).cgColor
            $0.shadowOpacity = 1
            $0.shadowOffset = CGSize(width: 0, height: 2)
            $0.shadowRadius = 4
        }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat, cornerSize: CGSize? = nil) {
        var path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        if let cornerSize = cornerSize {
            path = UIBezierPath(roundedRect: CGRect.init(x: 0, y: 0, width: cornerSize.width, height: cornerSize.height), byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        }
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }
    
    @IBInspectable
    var nvBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var bgColor: UIColor? {
        get {
            if let color = layer.backgroundColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.backgroundColor = color.cgColor
            } else {
                layer.backgroundColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

