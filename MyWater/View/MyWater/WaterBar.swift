//  WaterBar.swift
//  MyWater
//  Created by Ilya Zablotski

import SnapKit
import UIKit

final class WaterBar: UIView {
    
    // MARK: - UI Elements

    let waterBar: WaterBarShapeView = {
        let waterBar = WaterBarShapeView()
        waterBar.transform = waterBar.transform.rotated(by: 270 * .pi / 180)
        waterBar.progressTintColor = #colorLiteral(red: 0, green: 0.9872947335, blue: 1, alpha: 1)
        waterBar.trackTintColor = #colorLiteral(red: 0, green: 0.6108772159, blue: 1, alpha: 1)
        return waterBar
    }()

    let percentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.alpha = 0.7
        label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        label.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 50)
        label.addShadow()
        return label
    }()

    let glassStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.tintColor = .white
        stepper.addShadow()
        stepper.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        stepper.isHidden = true
        return stepper
    }()

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        setupView()
        setupViewConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func animatePercentLabel(from startValue: Float, to endValue: Float, duration: TimeInterval) {
        let stepTime = duration / abs(Double(endValue - startValue))
        var currentValue = startValue
        let increment = startValue < endValue ? 1 : -1

        Timer.scheduledTimer(withTimeInterval: stepTime, repeats: true) { timer in
            currentValue += Float(increment)

            if (increment > 0 && currentValue >= endValue) || (increment < 0 && currentValue <= endValue) {
                currentValue = endValue
                timer.invalidate()
            }

            self.percentLabel.text = "\(Int(currentValue))%"
        }
    }
}

// MARK: - Private Methods

private extension WaterBar {
    private func setupView() {
        [waterBar, glassStepper].forEach(addSubview)
        waterBar.addSubviews(percentLabel)
    }

    private func setupViewConstraints() {
        waterBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(400)
            make.width.equalTo(320)
        }

        percentLabel.snp.makeConstraints { make in
            make.center.equalTo(waterBar)
        }

        glassStepper.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(waterBar.snp.bottom).offset(10)
        }
    }
}
