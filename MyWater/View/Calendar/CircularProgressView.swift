//  CircularProgressView.swift
//  MyWater
//  Created by Ilya Zablotski

import UIKit

final class CircularProgressView: UIView {
    
    var progressLayer = CAShapeLayer()
    var trackLayer = CAShapeLayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    func createCircularPath() {
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -.pi / 2, endAngle: 1.5 * .pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = #colorLiteral(red: 0, green: 0.6108772159, blue: 1, alpha: 1)
        trackLayer.lineWidth = 50.0
        trackLayer.lineCap = .round
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = #colorLiteral(red: 0, green: 0.9872947335, blue: 1, alpha: 1)
        progressLayer.lineWidth = 50.0
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0.01
        progressLayer.shadowColor = UIColor.black.cgColor
        progressLayer.shadowOffset = .zero
        progressLayer.shadowOpacity = 0.6
        progressLayer.shadowRadius = 7
        layer.addSublayer(progressLayer)
    }
    
    func setProgress(_ progressConstant: Float, animated: Bool) {
        let progress = CGFloat(progressConstant)
            
        if animated {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.duration = 1.0
            animation.fromValue = progressLayer.strokeEnd
            animation.toValue = progress
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            progressLayer.strokeEnd = progress
            progressLayer.add(animation, forKey: "animateProgress")
        } else {
            progressLayer.strokeEnd = progress
        }
    }
}
