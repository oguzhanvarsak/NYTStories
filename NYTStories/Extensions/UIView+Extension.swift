//
//  UIView+Extension.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 20.05.2022.
//

import UIKit

extension UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
