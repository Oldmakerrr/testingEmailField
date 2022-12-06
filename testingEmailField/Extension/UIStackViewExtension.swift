//
//  UIStackViewExtension.swift
//  testingEmailField
//
//  Created by Apple on 20.03.2022.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubViews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubViews)
        self.axis = axis
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
