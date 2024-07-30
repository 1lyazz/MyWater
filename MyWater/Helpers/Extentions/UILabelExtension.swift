//  UILabelExtension.swift
//  MyWater
//  Created by Ilya Zablotski

import UIKit

extension UILabel {
    
    func setLabelStyle(font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment? = .center, numberOfLines: Int? = 1) {
        guard let textAlignment = textAlignment,
              let numberOfLines = numberOfLines
        else { return }

        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}
