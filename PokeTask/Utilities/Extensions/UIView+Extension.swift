//
//  UIView+Extension.swift
//  PokeTask
//
//  Created by Burak AKCAN on 28.09.2022.
//

import Foundation
import UIKit

extension UIView {
    
    func fromLeftToRightRotate (){
        let animation = CABasicAnimation(keyPath: "transform")
        var transform = CATransform3DIdentity
        transform.m34 = 0.002
        animation.toValue = CATransform3DRotate(transform, CGFloat(180 * Double.pi / 180.0), 0, 1, 0)
        animation.duration = 0.5
        self.layer.add(animation, forKey: "transform")
    }
    
    func fromBottomToTopRotate(){
        let animation = CABasicAnimation(keyPath: "transform")
        var transform = CATransform3DIdentity
        transform.m34 = 0.002
        animation.toValue = CATransform3DRotate(transform, CGFloat(180 * Double.pi / 180.0), 1, 0, -0.08)
        animation.duration = 0.5
        self.layer.add(animation, forKey: "transform")
    }
}
