//
//  AppProtocols.swift
//  dailyFxNews
//
//  Created by raja padala on 07/11/21.
//

import Foundation
import UIKit

protocol ViewGradientProtocol {
    var color1 : UIColor {get set}
    var color2 : UIColor {get set}
    
    func applyGradientBackground(view: UIView, isTopToBottom: Bool)
}

extension ViewGradientProtocol where Self: UIView {
    func applyGradientBackground(view: UIView, isTopToBottom: Bool) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        if isTopToBottom == true {
            gradientLayer.locations = [0.0, 1.0]
        } else {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        }
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = 10
        view.layer.sublayers?.filter{ $0 is CAGradientLayer }.forEach{ $0.removeFromSuperlayer() }

        view.layer.insertSublayer(gradientLayer, at:0)
    }
}

extension ViewGradientProtocol where Self: UIViewController {
    
}



