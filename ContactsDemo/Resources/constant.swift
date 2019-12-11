//
//  constant.swift
//  ContactsDemo
//
//  Created by Prithvi Raj on 10/12/19.
//  Copyright © 2019 Prithvi Raj. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Shake view
extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

// MARK: - padding space in UITEXTFIELD
extension UITextField {
    func LeftSpace() {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftViewMode = .always
    }
}
