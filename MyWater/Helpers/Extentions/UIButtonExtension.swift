//  UIButtonExtension.swift
//  MyWater
//  Created by Ilya Zablotski

import AVFoundation
import Foundation
import UIKit

extension UIButton {
    
    // Style for app buttons
    func setAppButtonStyle(backgroundImage: String, title: String? = "", titleColor: UIColor? = .clear) {
        guard let title = title,
              let titleColor = titleColor
        else { return }

        let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        setAttributedTitle(attributedTitle, for: .normal)
        setTitleColor(titleColor, for: .normal)
        setBackgroundImage(UIImage(named: backgroundImage), for: .normal)
        adjustsImageWhenHighlighted = false
        setShadow()
    }

    // Shadow for buttons
    func setShadow() {
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4.0
        layer.masksToBounds = false
    }
}
