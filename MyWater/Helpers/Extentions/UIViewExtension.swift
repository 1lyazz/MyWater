//  UIViewExtension.swift
//  MyWater
//  Created by Ilya Zablotski

import UIKit

extension UIView {
    
    func setSettingViewStyle() {
        self.layer.cornerRadius = 30
        self.addShadow()
        self.backgroundColor = #colorLiteral(red: 0.06453060359, green: 0.3772945702, blue: 0.9141336083, alpha: 1)
    }
}
