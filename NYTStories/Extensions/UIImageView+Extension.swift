//
//  UIImageView+Extension.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 20.05.2022.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageAsync(_ image: UIImage?) {
        
        DispatchQueue.main.async {
            self.alpha = 0
            self.image = image
            self.fadeIn()
        }
    }
}
