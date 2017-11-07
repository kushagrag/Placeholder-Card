//
//  ShimmerView.swift
//  Placeholder Cards
//
//  Created by Kushagra Gupta on 03/11/17.
//  Copyright © 2017 Kushagra Gupta. All rights reserved.
//

import UIKit

class ShimmerView: UIView {

    var gradientLayer: CAGradientLayer!
    var hasAnimation: Bool {
        return gradientLayer.animation(forKey: gradientAnimationKey) != nil
    }
    let gradientAnimationKey = "Move Gradient"

    @IBInspectable var startAnimatingOnLoad: Bool = true

    override func draw(_ rect: CGRect) {
        addGradientLayer()
        if startAnimatingOnLoad {
            startAnimating()
        }
    }

    func addGradientLayer() {
        gradientLayer = getGradientLayer()
        layer.addSublayer(gradientLayer)
    }

    func getGradientLayer() -> CAGradientLayer {
        let newGradientLayer = CAGradientLayer()
        newGradientLayer.frame = bounds
        let backgroundColor = UIColor(displayP3Red: 246 / 255, green: 247 / 255, blue: 248 / 255, alpha: 1.0).cgColor
        let color = UIColor(white: 238 / 255, alpha: 1.0).cgColor
        newGradientLayer.colors = [backgroundColor, color, backgroundColor]
        newGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        newGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        newGradientLayer.locations = [-0.3, -0.15, 0.0]

        return newGradientLayer
    }

    func startAnimating() {
        DispatchQueue.main.async {
            if !self.hasAnimation {
               self.addAnimation()
            }
        }
    }

    func stopAnimating() {
        gradientLayer.removeAnimation(forKey: gradientAnimationKey)
    }

    func addAnimation() {
        gradientLayer.add(getGradientAnimation(), forKey: gradientAnimationKey)
    }

    func getGradientAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.toValue = [1.0, 1.15, 1.3]
        animation.duration = 1.0
        animation.fillMode = kCAFillModeForwards
        animation.repeatCount = Float.infinity
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)

        return animation
    }

}
