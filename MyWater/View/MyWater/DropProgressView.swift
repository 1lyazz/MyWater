//  DropProgressView.swift
//  MyWater
//  Created by Ilya Zablotski

import UIKit

final class DropProgressView: UIView {
    
    private let progressView = UIProgressView(progressViewStyle: .default)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressView.topAnchor.constraint(equalTo: topAnchor),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let dropPath = UIBezierPath()
        dropPath.move(to: CGPoint(x: bounds.width / 2, y: 0))
        dropPath.addQuadCurve(to: CGPoint(x: 0, y: bounds.height), controlPoint: CGPoint(x: 0, y: bounds.height / 2))
        dropPath.addQuadCurve(to: CGPoint(x: bounds.width, y: bounds.height), controlPoint: CGPoint(x: bounds.width, y: bounds.height / 2))
        dropPath.addQuadCurve(to: CGPoint(x: bounds.width / 2, y: 0), controlPoint: CGPoint(x: bounds.width / 2, y: bounds.height / 2))
        dropPath.close()
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = dropPath.cgPath
        layer.mask = maskLayer
    }
    
    func setProgress(_ progress: Float, animated: Bool) {
        progressView.setProgress(progress, animated: animated)
    }
}
