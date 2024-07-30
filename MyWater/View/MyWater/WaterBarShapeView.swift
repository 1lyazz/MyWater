//  WaterBarShapeView.swift
//  MyWater
//  Created by Ilya Zablotski

import UIKit

final class WaterBarShapeView: UIProgressView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupWaterBarShape()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupWaterBarShape()
    }
    
    private func setupWaterBarShape() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 310, y: 200))
        path.addQuadCurve(to: CGPoint(x: 10, y: 200), controlPoint: CGPoint(x: 0, y: 0))
        path.addQuadCurve(to: CGPoint(x: 310, y: 200), controlPoint: CGPoint(x: 0, y: 400))
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
        self.addShadow()
        shapeLayer.shadowPath = path.cgPath
        shapeLayer.shadowOffset = .zero
        shapeLayer.shadowOpacity = 1
        shapeLayer.shadowRadius = 5
    }
}

